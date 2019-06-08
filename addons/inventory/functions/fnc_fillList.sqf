/*
 * Author: mharis001
 * Populates the listbox with items from the current category.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_fillList
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display"];

private _itemsList = uiNamespace getVariable QGVAR(itemsList);
private _category = lbCurSel (_display displayCtrl IDC_CATEGORY) - 1;
private _filter = toLower ctrlText (_display displayCtrl IDC_SEARCH_BAR);

// Clear the listbox
private _ctrlList = _display displayCtrl IDC_LIST;
lnbClear _ctrlList;

// Handle current cargo, no specific category
if (_category == -1) then {
    private _cfgMagazines = configFile >> "CfgMagazines";
    private _cfgVehicles  = configFile >> "CfgVehicles";
    private _cfgGlassess  = configFile >> "CfgGlasses";
    private _cfgWeapons   = configFile >> "CfgWeapons";

    private _cargo = _display getVariable QGVAR(cargo);

    {
        _x params ["_cargoItems", "_cargoCounts"];

        {
            private _count = _cargoCounts select _forEachIndex;

            // Get appropriate config for each item (items can be from any category)
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
                    _cfgGlassess >> _x;
                };
                default {
                    _cfgWeapons >> _x;
                };
            };

            // Add item to listbox if not filtered
            private _displayName = getText (_config >> "displayName");
            if (toLower _displayName find _filter != -1) then {
                private _picture = getText (_config >> "picture");
                private _tooltip = format ["%1\n%2", _displayName, _x];

                private _index = _ctrlList lnbAddRow ["", _displayName, str _count];
                _ctrlList lnbSetData    [[_index, 0], _x];
                _ctrlList lnbSetPicture [[_index, 0], _picture];
                _ctrlList lbSetTooltip  [_index * count lnbGetColumnsPosition _ctrlList, _tooltip];
            };
        } forEach _cargoItems;
    } forEach _cargo;
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

    // Get cargo for current category
    private _categoryCargo = [_display] call FUNC(getCargo);
    _categoryCargo params ["_cargoItems", "_cargoCounts"];

    {
        // Add item to listbox if not filtered
        private _displayName = getText (_config >> _x >> "displayName");
        if (toLower _displayName find _filter != -1) then {
            private _picture = getText (_config >> _x >> "picture");
            private _tooltip = format ["%1\n%2", _displayName, _x];
            private _count = "0";
            private _alpha = 0.5;

            // Get item count and increase alpha if item is in cargo
            private _itemIndex = _cargoItems find _x;

            if (_itemIndex != -1) then {
                _count = str (_cargoCounts select _itemIndex);
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

_ctrlList lnbSort [1];

[_display] call FUNC(updateButtons);
