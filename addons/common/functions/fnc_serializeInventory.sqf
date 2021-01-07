#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns serialized inventory data for the given object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * Serialized Inventory <ARRAY>
 *
 * Example:
 * [_object] call zen_common_fnc_serializeInventory
 *
 * Public: No
 */

params ["_object"];

// Handle containers inside the object's inventory
private _containers = everyContainer _object apply {
    _x params ["_type", "_object"];

    [_type, _object call FUNC(serializeInventory)]
};

[getItemCargo _object, weaponsItemsCargo _object, magazinesAmmoCargo _object, getBackpackCargo _object, _containers]
