#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given unit or vehicle's weapon or muzzle is reloading.
 *
 * Arguments:
 * 0: Unit or Vehicle <OBJECT>
 * 1: Turret Path <ARRAY> (default: [0])
 *   - Only used if the given entity is a vehicle.
 * 2: Weapon or Muzzle <STRING> (default: "")
 *   - Use "" for current weapon.
 *
 * Return Value:
 * Is Reloading <BOOL>
 *
 * Example:
 * [_unit, "arifle_MX_F"] call zen_common_fnc_isReloading
 *
 * Public: No
 */

params [
    ["_entity", objNull, [objNull]],
    ["_turretPath", [0], [[]]],
    ["_weaponOrMuzzle", "", [""]]
];

// Get given weapon or muzzle's current state
private _state = if (_entity isKindOf "CAManBase") then {
    _entity weaponState _weaponOrMuzzle
} else {
    weaponState [_entity, _turretPath, _weaponOrMuzzle]
};

_state params ["", "", "", "", "", "_roundReloadPhase", "_magazineReloadPhase"];

// Is reloading if round or magazine reload phase is > 0
_roundReloadPhase > 0 || {_magazineReloadPhase > 0}
