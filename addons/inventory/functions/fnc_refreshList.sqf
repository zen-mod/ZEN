#include "script_component.hpp"
/*
 * Author: mharis001
 * Refreshes the list by populating it with items based on the current category.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_refreshList
 *
 * Public: No
 */

params ["_display"];

private _itemsList = uiNamespace getVariable QGVAR(itemsList);
private _category = lbCurSel (_display displayCtrl IDC_CATEGORY) - 1;
private _filter = toLower ctrlText (_display displayCtrl IDC_SEARCH_BAR);

// Clear the list
private _ctrlList = _display displayCtrl IDC_LIST;
lnbClear _ctrlList;

// No specific category, process all items in current cargo
if (_category == -1) then {
    private _cfgGlasses   = configFile >> "CfgGlasses";
    private _cfgMagazines = configFile >> "CfgMagazines";
    private _cfgVehicles  = configFile >> "CfgVehicles";
    private _cfgWeapons   = configFile >> "CfgWeapons";

    {
        _x params ["_types", "_counts"];

        {
            // Get appropriate config for each item, items can be from any category
            private _config = switch (true) do {
                case (_x in (_itemsList select 7));
                case (_x in (_itemsList select 20));
                case (_x in (_itemsList select 21)): {
                    _cfgMagazines >> _x;
                };
                case (_x in (_itemsList select 11)): {
                    _cfgVehicles >> _x;
                };
                case (_x in (_itemsList select 12)): {
                    _cfgGlasses >> _x;
                };
                default {
                    _cfgWeapons >> _x;
                };
            };

            private _displayName = getText (_config >> "displayName");

            // Check if the item is matches the current filter
            if (_filter in toLower _displayName) then {
                private _picture = getText (_config >> "picture");
                private _tooltip = format ["%1\n%2", _displayName, _x];

                private _index = _ctrlList lnbAddRow ["", _displayName, str (_counts select _forEachIndex)];
                _ctrlList lnbSetData    [[_index, 0], _x];
                _ctrlList lnbSetPicture [[_index, 0], _picture];
                _ctrlList lbSetTooltip  [_index * count lnbGetColumnsPosition _ctrlList, _tooltip];
            };
        } forEach _types;
    } forEach (_display getVariable QGVAR(cargo));
} else {
    // Get config for current category
    private _config = switch (true) do {
        case (_category in [7, 20, 21]): {
            configFile >> "CfgMagazines";
        };
        case (_category == 11): {
            configFile >> "CfgVehicles";
        };
        case (_category == 12): {
            configFile >> "CfgGlasses";
        };
        default {
            configFile >> "CfgWeapons";
        };
    };

    // Get cargo for the current category
    (_display call FUNC(getCargo)) params ["_types", "_counts"];

    {
        private _config = _config >> _x;
        private _displayName = getText (_config >> "displayName");

        // Check if the item is matches the current filter
        if (_filter in toLower _displayName) then {
            private _picture = getText (_config >> "picture");
            private _tooltip = format ["%1\n%2", _displayName, _x];
            private _count = "0";
            private _alpha = 0.5;

            // Get item count and increase alpha if the item is in cargo
            private _itemIndex = _types find _x;

            if (_itemIndex != -1) then {
                _count = str (_counts select _itemIndex);
                _alpha = 1;
            };

            private _index = _ctrlList lnbAddRow ["", _displayName, _count];
            _ctrlList lnbSetData    [[_index, 0], _x];
            _ctrlList lnbSetPicture [[_index, 0], _picture];
            _ctrlList lnbSetColor   [[_index, 1], [1, 1, 1, _alpha]];
            _ctrlList lnbSetColor   [[_index, 2], [1, 1, 1, _alpha]];
            _ctrlList lbSetTooltip  [_index * count lnbGetColumnsPosition _ctrlList, _tooltip];
        };
    } forEach (_itemsList select _category);
};

// Sort the list by item name
_ctrlList lnbSort [1];

// Update list buttons
[_display] call FUNC(updateButtons);
