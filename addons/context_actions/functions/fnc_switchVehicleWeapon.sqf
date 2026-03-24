#include "script_component.hpp"
/*
 * Author: Ampersand
 * Switches the given vehicle turret's weapon, muzzle, and magazine.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Turret Path <ARRAY>
 * 2: Weapon <STRING>
 * 3: Muzzle <STRING>
 * 4: Magazine <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, _turretPath, _weapon, _muzzle, _magazine] call zen_context_actions_fnc_switchVehicleWeapon
 *
 * Public: No
 */

params ["_vehicle", "_turretPath", "_weapon", "_muzzle", "_magazine"];

// For regular (non-pylon) magazines, load the magazine instantly into the selected weapon
// Pylon magazines work differently and only need to have the corresponding pylon weapon selected
if !(_magazine in getPylonMagazines _vehicle) then {
    [_vehicle, _turretPath, _weapon, _magazine] call EFUNC(common,loadMagazineInstantly);
};

// Select the given weapon and muzzle on the vehicle's turret
[QEGVAR(common,selectWeaponTurret), [_vehicle, _weapon, _turretPath, _muzzle], _vehicle, _turretPath] call CBA_fnc_turretEvent;
