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
        // 3, 4, and 5 are indices of uniform, vest, and backpack info in loadout arrays, respectively
        for "_i" from 3 to 5 do {
            (_x select _i param [1, []]) sort true;
        };
    } forEach [_current, _default];

    _current isEqualTo _default
};

// For all other objects, compare current inventory against config defined one for any missing or extra items
private _current = [getItemCargo _object, getWeaponCargo _object, getMagazineCargo _object, getBackpackCargo _object];
private _default = [_object] call FUNC(getDefaultInventory);

// Sort inventory arrays, their contents can be indentical but the arrays may be different
// depending on the order they were added to the container
{
    {
        {
            _x sort true;
        } forEach _x;
    } forEach _x;
} forEach [_current, _default];

_current isEqualTo _default
