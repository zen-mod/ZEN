#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the relevant cargo array based on given item.
 * If no item is provided, will return based on current category.
 * Used by other functions to work with the correct cargo array.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Item <STRING> (default: "")
 *
 * Return Value:
 * Cargo <ARRAY>
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_getCargo
 *
 * Public: No
 */

params ["_display", ["_item", ""]];

private _index = if (_item == "") then {
    if (_display getVariable [QGVAR(weapon), ""] == "") then {
        private _category = lbCurSel (_display displayCtrl IDC_CATEGORY) - 1;

        switch (_category) do {
            case ITEMS_PRIMARY;
            case ITEMS_SECONDARY;
            case ITEMS_HANDGUN;
            case ITEMS_BINOCULARS: {
                CARGO_WEAPONS
            };
            case ITEMS_MAGAZINES;
            case ITEMS_THROW;
            case ITEMS_PUT: {
                CARGO_MAGAZINES
            };
            case ITEMS_BACKPACKS: {
                CARGO_BACKPACKS
            };
            default {
                CARGO_ITEMS
            };
        };
    } else {
        private _category = lbCurSel (_display displayCtrl IDC_WEAPON_CATEGORY);
        [CARGO_ITEMS, CARGO_MAGAZINES] select (_category == 4)
    };
} else {
    private _itemsList = uiNamespace getVariable QGVAR(itemsList);

    switch (true) do {
        case (_item in (_itemsList select ITEMS_PRIMARY));
        case (_item in (_itemsList select ITEMS_SECONDARY));
        case (_item in (_itemsList select ITEMS_HANDGUN));
        case (_item in (_itemsList select ITEMS_BINOCULARS)): {
            CARGO_WEAPONS
        };
        case (_item in (_itemsList select ITEMS_MAGAZINES));
        case (_item in (_itemsList select ITEMS_THROW));
        case (_item in (_itemsList select ITEMS_PUT)): {
            CARGO_MAGAZINES
        };
        case (_item in (_itemsList select ITEMS_BACKPACKS)): {
            CARGO_BACKPACKS
        };
        default {
            CARGO_ITEMS
        };
    };
};

_display getVariable QGVAR(cargo) select _index
