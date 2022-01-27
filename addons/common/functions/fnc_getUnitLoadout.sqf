#include "script_component.hpp"
/*
 * Author: mjc4wilton
 * Returns the given unit's loadout. Handles filtering items with unique radio IDs.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Unit Loadout Array <ARRAY>
 *
 * Example:
 * [_unit] call zen_common_fnc_getUnitLoadout
 *
 * Public: No
 */

params ["_unit"];

private _loadout = getUnitLoadout _unit;

// ACRE radios
if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
    _loadout = [_loadout] call acre_api_fnc_filterUnitLoadout;
};

_loadout
