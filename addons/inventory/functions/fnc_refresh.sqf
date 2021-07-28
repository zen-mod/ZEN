#include "script_component.hpp"
/*
 * Author: mharis001
 * Refreshes the list by populating it with items.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_refresh
 *
 * Public: No
 */

params ["_display"];

private _ctrlList = _display displayCtrl IDC_LIST;
lnbClear _ctrlList;

// Allow for items to be searched using class names by adding the 'class ' prefix
private _filter = toLower ctrlText (_display displayCtrl IDC_SEARCH_BAR);
private _filterByClass = _filter select [0, 6] == "class ";

if (_filterByClass) then {
    _filter = _filter select [6];
};

// Function that populates the list with the specified items using the amounts from the given cargo array
private _fnc_populate = {
    params ["_cargo", "_items"];
    _cargo params ["_types", "_counts"];

    // Add items from cargo if none are given (used for current cargo category)
    if (isNil "_items") then {
        _items = _types;
    };

    {
        private _config = [_x] call CBA_fnc_getItemConfig;
        private _name = getText (_config >> "displayName");

        // Handle searching items by display name or class name
        private _text = [_name, _x] select _filterByClass;

        if (_filter in toLower _text) then {
            private _picture = getText (_config >> "picture");
            private _tooltip = format ["%1\n%2", _name, _x];
            private _count = _counts param [_types find _x, 0];
            private _alpha = [ALPHA_NONE, ALPHA_SOME] select (_count > 0);

            private _index = _ctrlList lnbAddRow ["", _name, str _count];
            _ctrlList lnbSetPicture [[_index, 0], _picture];
            _ctrlList lnbSetTooltip [[_index, 0], _tooltip];
            _ctrlList lnbSetColor   [[_index, 1], [1, 1, 1, _alpha]];
            _ctrlList lnbSetColor   [[_index, 2], [1, 1, 1, _alpha]];
            _ctrlList lnbSetValue   [[_index, 2], _count];
            _ctrlList lnbSetData    [[_index, 0], _x];
        };
    } forEach _items;
};

if (_display getVariable [QGVAR(weapon), ""] == "") then {
    private _category = lbCurSel (_display displayCtrl IDC_CATEGORY) - 1;

    if (_category == -1) then {
        // No specific category, add all items in current cargo
        {
            [_x] call _fnc_populate;
        } forEach (_display getVariable QGVAR(cargo));
    } else {
        // Specific category selected, get items to add from the master items list
        private _cargo = _display call FUNC(getCargo);
        private _items = uiNamespace getVariable QGVAR(itemsList) select _category;
        [_cargo, _items] call _fnc_populate;
    };
} else {
    // In weapon specific mode, add items compatible with the selected weapon
    private _cargo = _display call FUNC(getCargo);
    private _items = _display call FUNC(getWeaponItems);
    [_cargo, _items] call _fnc_populate;
};

// Refresh the list's sorting
private _ctrlSorting = _display displayCtrl IDC_SORTING;
_ctrlSorting lnbSetCurSelRow -1;

// Update other display elements
_display call FUNC(update);
