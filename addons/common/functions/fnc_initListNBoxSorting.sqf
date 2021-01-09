#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the given ListNBox sorting control with buttons to select between sort modes.
 *
 * The items of the first row of the sorting list specify the different sort options.
 * A cell with non-empty data specifies that it sorts its respective column by value instead of by text.
 *
 * Optionally, column sort indexes can be specified to, for example, make multiple sort options
 * sort using the same column of the content list.
 *
 * The content list's sorting can be manually refreshed by changing the selection of the sorting
 * list using the lnbSetCurSelRow command.
 *
 * Arguments:
 * 0: Sorting List <CONTROL>
 * 1: Content List <CONTROL>
 * 2: Sort Indexes <ARRAY> (default: [])
 * 3: Perform Initial Sort <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, CONTROL, [0, 0, 1], true] call zen_common_fnc_initListNBoxSorting
 *
 * Public: No
 */

#define SORT_NONE 0
#define SORT_UP   1
#define SORT_DOWN 2

#define ICON_SORT_NONE "\a3\3den\data\displays\display3densave\sort_none_ca.paa"
#define ICON_SORT_UP   "\a3\3den\data\displays\display3densave\sort_up_ca.paa"
#define ICON_SORT_DOWN "\a3\3den\data\displays\display3densave\sort_down_ca.paa"

params [
    ["_ctrlSorting", controlNull, [controlNull]],
    ["_ctrlContent", controlNull, [controlNull]],
    ["_sortIndexes", [], [[]]],
    ["_initialSort", false, [false]]
];

private _display = ctrlParent _ctrlSorting;
private _controlsGroup = ctrlParentControlsGroup _ctrlSorting;

ctrlPosition _ctrlSorting params ["_posX", "_posY", "_posW", "_posH"];

// Create invisible buttons for each column (sort mode) on top of the sorting control
private _columnPositions = lnbGetColumnsPosition _ctrlSorting;

{
    // Find the end position of this column (use remaining space if it is the last column)
    private _begPos = _x;
    private _endPos = _columnPositions param [_forEachIndex + 1, 1];

    // Create the invisible button control and position it over its respective column
    private _ctrlButton = _display ctrlCreate ["ctrlButtonFilter", -1, _controlsGroup];
    _ctrlButton ctrlSetPosition [_posX + _begPos * _posW, _posY, (_endPos - _begPos) * _posW, _posH];
    _ctrlButton ctrlCommit 0;

    // Update the sorting mode when the button is clicked
    [_ctrlButton, "ButtonClick", {
        _thisArgs params ["_ctrlSorting"];
        _thisArgs call (_ctrlSorting getVariable QFUNC(update));
    }, [_ctrlSorting, _forEachIndex]] call CBA_fnc_addBISEventHandler;
} forEach _columnPositions;

_ctrlSorting setVariable [QFUNC(update), {
    params ["_ctrlSorting", ["_selected", -1]];
    (_ctrlSorting getVariable QGVAR(params)) params ["_ctrlContent", "_sortIndexes"];

    // Check if this update was triggered by clicking a button (instead of a manual refresh)
    private _toggled = _selected != -1;

    for "_i" from 0 to (count lnbGetColumnsPosition _ctrlSorting - 1) do {
        private _value = _ctrlSorting lnbValue [0, _i];

        // Refresh using the first non-none sort mode if one was not selected
        if (_selected == -1 && {_value != SORT_NONE}) then {
            _selected = _i;
        };

        // Sort the content list using this sort mode if it is selected
        if (_i == _selected) then {
            // Cycle between sort directions (up/down) when update is triggered using the buttons
            if (_toggled) then {
                _value = [SORT_UP, SORT_DOWN, SORT_UP] select _value;
            };

            // Get the column sort index associated with this sort mode
            private _index = _sortIndexes param [_i, _selected];
            private _order = _value == SORT_DOWN;

            // Sort by value if the column's data is not empty
            if (_ctrlSorting lnbData [0, _i] == "") then {
                _ctrlContent lnbSort [_index, _order];
            } else {
                _ctrlContent lnbSortByValue [_index, _order];
            };
        } else {
            _value = SORT_NONE;
        };

        // Update the column's value and picture
        private _picture = [ICON_SORT_NONE, ICON_SORT_UP, ICON_SORT_DOWN] select _value;
        _ctrlSorting lnbSetValue [[0, _i], _value];
        _ctrlSorting lnbSetPicture [[0, _i], _picture];
    };

    // Reset row selection after manually triggered updates
    if (lnbCurSelRow _ctrlSorting != -1) then {
        _ctrlSorting lnbSetCurSelRow -1;
    };
}];

_ctrlSorting setVariable [QGVAR(params), [_ctrlContent, _sortIndexes]];

// Refresh sorting when the selection of the sorting control changes
// Allows for sorting to be manually triggered using the lnbSetCurSelRow command
_ctrlSorting ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlSorting"];

    _ctrlSorting call (_ctrlSorting getVariable QFUNC(update));
}];

// Initially sort the content list if required
if (_initialSort) then {
    _ctrlSorting lnbSetCurSelRow -1;
};
