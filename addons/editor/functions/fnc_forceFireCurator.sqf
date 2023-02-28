#include "script_component.hpp"
/*
 * Author: Ampersand
 * Makes the given unit fire their weapon while the curator Force Fire key is pressed.
 *
 * Arguments:
 * 0: Units <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit] call zen_common_fnc_forceFireCurator
 *
 * Public: No
 */

params ["_unit", "_curatorClientID"];

if (_unit isEqualTo []) exitWith {
    GVAR(forceFiringCurators) = GVAR(forceFiringCurators) - [_curatorClientID];
};

if (_unit isEqualType []) exitWith {
    {
        [_x, _curatorClientID] call FUNC(forceFireCurator);
    } forEach _unit;
};

// If a vehicle is given directly, use its gunner as the unit
if !(_unit isKindOf "CAManBase") then {
    _unit = [_unit] call EFUNC(common,firstTurretUnit);
};

if (!local _unit) exitWith {
    [QGVAR(forceFireCurator), _this, _unit] call CBA_fnc_targetEvent;
};

if (_unit getVariable [QGVAR(isFiring), false]) exitWith {};

// Track which curators are forcing fire on local machine
GVAR(forceFiringCurators) pushBackUnique _curatorClientID;
_unit setVariable [QGVAR(isFiring), true];

// Repeating fire for local shooters
[{
    params ["_unit", "_curatorClientID", "_shotTime", "_endTime"];

    if (
        !(_curatorClientID in GVAR(forceFiringCurators))
        || {CBA_missionTime > _endTime}
        || {!([_unit] call EFUNC(common,canFire))}
    ) exitWith {
        _unit setVariable [QGVAR(isFiring), nil];

        true // Exit
    };

    if (CBA_missionTime > _shotTime) then {
        [_unit] call EFUNC(common,forceFire);

        private _vehicle = vehicle _unit;
        private _turretPath = _vehicle unitTurret _unit;

        // Set time until the next shot based on the weapon's ammo reloading time and whether the current burst is finished
        private _reloadTime = [_vehicle, _turretPath] call EFUNC(common,getWeaponReloadTime);
        _shotTime = CBA_missionTime + _reloadTime max 0.1;

        _this set [2, _shotTime];
    };

    false // Continue
}, {}, [_unit, _curatorClientID, 0, CBA_missionTime + 10]] call CBA_fnc_waitUntilAndExecute;
