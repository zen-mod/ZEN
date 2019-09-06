#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the relevant cargo list array based on given item.
 * If no item is provided, will return based on current category.
 * Used by other functions to work with the correct cargo array.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Item Classname <STRING> (default: "")
 *
 * Return Value:
 * Cargo List <ARRAY>
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_getCargo
 *
 * Public: No
 */

params ["_controlsGroup", ["_item", ""]];

private _cargo = _controlsGroup getVariable QEGVAR(attributes,value);

private _index = if (_item == "") then {
    private _category = lbCurSel (_controlsGroup controlsGroupCtrl IDC_CATEGORY) - 1;

    switch (true) do {
        case (_category in [0, 1, 2, 14]): {1};
        case (_category in [7, 20, 21]): {2};
        case (_category == 11): {3};
        default {0};
    };
} else {
    private _itemsList = uiNamespace getVariable QGVAR(itemsList);

    switch (true) do {
        case (_item in (_itemsList select 0));
        case (_item in (_itemsList select 1));
        case (_item in (_itemsList select 2));
        case (_item in (_itemsList select 14)): {1};
        case (_item in (_itemsList select 7));
        case (_item in (_itemsList select 20));
        case (_item in (_itemsList select 21)): {2};
        case (_item in (_itemsList select 11)): {3};
        default {0};
    };
};

_cargo select _index
