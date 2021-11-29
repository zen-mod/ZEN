#include "script_component.hpp"
/*
 * Author: mjc4wilton
 * Returns the unit loadout array (sanitized)
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * Unit Loadout Array <ARRAY>
 *
 * Example:
 * [player] call zen_common_fnc_getUnitLoadoutSafe
 *
 * Public: No
 */

params ["_unit"];

private _loadout = getUnitLoadout _unit;

// ACRE Sanitization
if (isClass(configFile >> "CfgPatches" >> "acre_main")) then {
    _loadout = [_loadout] call acre_api_fnc_filterUnitLoadout;
}

_loadout // Return value
