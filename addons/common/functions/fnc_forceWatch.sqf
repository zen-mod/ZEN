#include "script_component.hpp"
/*
 * Author: mharis001
 * Makes the given unit watch the specified target.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Target <OBJECT|ARRAY> (default: objNull)
 *   - When given objNull, the unit stops watching its current target.
 *   - Positions must be in AGL format.
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, _target] call zen_common_fnc_forceWatch
 *
 * Public: No
 */

params [["_unit", objNull, [objNull]], ["_target", objNull, [objNull, []], 3]];

[QGVAR(doWatch), [[_unit, gunner _unit], _target], _unit] call CBA_fnc_targetEvent;

// If an object is given, make the unit target the object in addition to watching it
if (_target isEqualType objNull && {!isNull _target}) then {
    [QGVAR(doTarget), [[_unit, gunner _unit], _target], _unit] call CBA_fnc_targetEvent;
};

// Make vehicles or units in vehicles watch target by locking their turret cameras onto it
private _vehicle = vehicle _unit;

if (
    _unit isNotEqualTo _vehicle
    || {_unit isKindOf "LandVehicle"}
    || {_unit isKindOf "Air"}
    || {_unit isKindOf "Ship"}
) then {
    private _turretPaths = if (_unit isEqualTo _vehicle) then {
        _vehicle call FUNC(getAllTurrets)
    } else {
        [_vehicle unitTurret _unit]
    };

    if (_target isEqualType []) then {
        _target = AGLToASL _target;
    };

    {
        [QGVAR(lockCameraTo), [_vehicle, _target, _x, false], _vehicle, _x] call CBA_fnc_turretEvent;
    } forEach _turretPaths;
};
