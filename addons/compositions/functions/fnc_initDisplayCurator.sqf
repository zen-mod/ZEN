#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"
/*
 * Author: mharis001
 * Initializes the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_compositions_fnc_initDisplayCurator
 *
 * Public: No
 */

[{
    params ["_display"];

    private _ctrlTree = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY;

    // Remove the helper composition from the tree
    for "_i" from 0 to ((_ctrlTree tvCount [0]) - 1) do {
        if (_ctrlTree tvData [0, _i] == CATEGORY_STR) exitWith {
            _ctrlTree tvDelete [0, _i];
        };
    };

    // Initially hide the custom compositions panel if the compositions tree is not active
    if (GETMVAR(RscDisplayCurator_sections,[]) isNotEqualTo [1, 4]) then {
        private _ctrlPanel = _display displayCtrl IDC_PANEL_GROUP;
        _ctrlPanel ctrlShow false;
    };

    // Set the initial state of the randomize button
    private _ctrlRandomize = _display displayCtrl IDC_PANEL_RANDOMIZE;
    [_ctrlRandomize, false] call FUNC(buttonRandomize);

    // There are situations where the custom category is not shown in the tree
    // To workaround this, any needed tree additions are processed when tree items may change
    private _fnc_processAdditions = {
        params ["_ctrl"];

        private _display = ctrlParent _ctrl;
        [_display] call FUNC(processTreeAdditions);
    };

    private _searchIDC = [IDC_RSCDISPLAYCURATOR_CREATE_SEARCH, IDC_SEARCH_CUSTOM] select EGVAR(editor,disableLiveSearch);
    private _ctrlSearch = _display displayCtrl _searchIDC;
    _ctrlSearch ctrlAddEventHandler ["MouseButtonClick", _fnc_processAdditions];
    _ctrlSearch ctrlAddEventHandler ["KeyDown", _fnc_processAdditions];
    _ctrlSearch ctrlAddEventHandler ["KeyUp", _fnc_processAdditions];

    private _ctrlSearchButton = _display displayCtrl IDC_SEARCH_BUTTON;
    _ctrlSearchButton ctrlAddEventHandler ["ButtonClick", _fnc_processAdditions];

    // Add the custom compositions category (with custom icon on right)
    private _index = _ctrlTree tvAdd [[0], localize "str_radio_custom"];
    _ctrlTree tvSetData [[0, _index], CATEGORY_STR];
    _ctrlTree tvSetPictureRight [[0, _index], ICON_CUSTOM];
    _ctrlTree tvSetPictureRightColor [[0, _index], [1, 1, 1, 1]];
    _ctrlTree tvSetPictureRightColorSelected [[0, _index], [1, 1, 1, 1]];

    // Initially add all compositions to the tree
    GVAR(treeAdditions) = +GET_COMPOSITIONS;
    [_display] call FUNC(processTreeAdditions);

    _ctrlTree ctrlAddEventHandler ["TreeSelChanged", {call FUNC(handleTreeSelect)}];
}, _this] call CBA_fnc_execNextFrame;
