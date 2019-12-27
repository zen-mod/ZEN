#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given object's current inventory is the same as it's config defined one.
 * For infantry units, the loadout is compared (ignoring facewear).
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * Has Default Inventory <BOOL>
 *
 * Example:
 * [_object] call zen_common_fnc_hasDefaultInventory
 *
 * Public: No
 */

params ["_object"];

// Compare current loadout to config defined loadout if an infantry unit is given
if (_object isKindOf "CAManBase") exitWith {
    private _current = getUnitLoadout _object;
    private _default = getUnitLoadout typeOf _object;

    // Always match facewear because it is influenced by identity, not config inventory
    _default set [7, _current select 7];

    // Sort uniform, vest, and backpack item arrays, their contents can be indentical
    // but the arrays may be different depending on the order they were added to the container
    {
        for "_i" from 3 to 5 do {
            (_x select _i param [1, []]) sort true;
        };
    } forEach [_current, _default];

    _current isEqualTo _default
};

scopeName "Main";

// For all other objects, compare current inventory against config defined one for any missing or extra items
private _objectConfig = configFile >> "CfgVehicles" >> typeOf _object;

{
    _x params ["_inventory", "_config", "_entry"];
    _inventory params ["_types", "_counts"];

    // Config may not be in config case, use lowercase for comparisons
    _types = _types apply {toLower _x};

    {
        private _index = _types find toLower getText (_x >> _entry);

        // Exit if items of this type are not in the current inventory
        if (_index == -1) then {
            false breakOut "Main";
        };

        private _count = (_counts select _index) - getNumber (_x >> "count");

        // Exit if the there is not enough of the item in the current inventory
        if (_count < 0) then {
            false breakOut "Main";
        };

        // Remove the item if there are none remaining in the inventory
        // Otherwise, update the count in the current inventory
        if (_count == 0) then {
            _types  deleteAt _index;
            _counts deleteAt _index;
        } else {
            _counts set [_index, _count];
        };
    } forEach configProperties [_objectConfig >> _config, "isClass _x"];

    // Exit if the current inventory has extra items compared to config defined one
    if !(_types isEqualTo []) then {
        false breakOut "Main";
    };
} forEach [
    [getItemCargo _object,     "TransportItems",     "name"],
    [getWeaponCargo _object,   "TransportWeapons",   "weapon"],
    [getMagazineCargo _object, "TransportMagazines", "magazine"],
    [getBackpackCargo _object, "TransportBackpacks", "backpack"]
];

true // Unable to find any differences between current and config defined inventory
