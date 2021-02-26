#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the turret path that owns the given pylon.
 * Will return the config defined turret if the owner is ambiguous.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Pylon Index <NUMBER>
 *
 * Return Value:
 * Turret Path <ARRAY>
 *
 * Example:
 * [_vehicle, 0] call zen_common_fnc_getPylonTurret
 *
 * Public: No
 */

params ["_vehicle", "_pylonIndex"];

// Get the pylon magazine and current ammo for the given pylon index
private _pylonMagazine = getPylonMagazines _vehicle select _pylonIndex;
private _pylonAmmo = _vehicle ammoOnPylon (_pylonIndex + 1);

// Get turret paths for magazines of the same type and current ammo count
private _turretPaths = [];

{
    _x params ["_magazine", "_turretPath", "_ammoCount"];

    if (_magazine == _pylonMagazine && {_ammoCount == _pylonAmmo}) then {
        // Pylons uses [] for driver turret instead of the normal [-1]
        if (_turretPath isEqualTo [-1]) then {
            _turretPath = [];
        };

        _turretPaths pushBackUnique _turretPath;
    };
} forEach magazinesAllTurrets _vehicle;

// Exit with the matched turret path if only one was found
if (count _turretPaths == 1) exitWith {
    _turretPaths select 0
};

// More than one turret path or none were found, situation is ambiguous
// Return the config defined turret path for this pylon
private _pylonConfig = configOf _vehicle >> "Components" >> "TransportPylonsComponent" >> "Pylons";
getArray (configProperties [_pylonConfig, "isClass _x"] select _pylonIndex >> "turret")
