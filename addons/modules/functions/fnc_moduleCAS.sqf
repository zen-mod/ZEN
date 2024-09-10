#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to make an aircraft perform CAS.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: CAS Type <NUMBER>
 * 2: Plane Classname <STRING>
 * 3: Plane Weapons <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, 0, "B_Plane_Fighter_01_F", ["weapon_Fighter_Gun20mm_AA"]] call zen_modules_fnc_moduleCAS
 *
 * Public: No
 */

#define CAS_DISTANCE 3000
#define CAS_ALTITUDE 1000
#define CAS_SPEED 115
#define CAS_DURATION (([0, 0] distance [CAS_DISTANCE, CAS_ALTITUDE]) / CAS_SPEED)

#define FIRE_DURATION 3
#define FIRE_DELAY 0.1

#define CLEANUP_PLANE \
    private _group = group _plane; \
    {deleteVehicle _x} forEach units _group; \
    deleteVehicle _plane; \
    deleteGroup _group

params ["_logic", "_casType", "_planeClass", "_planeWeapons"];

private _logicPos = getPosASL _logic;
private _logicDir = getDir _logic;

private _planePos = _logic getPos [CAS_DISTANCE, _logicDir + 180];
_planePos set [2, (_logicPos select 2) + CAS_ALTITUDE];

// Spawn the plane and crew and set their behaviour
private _plane = createVehicle [_planeClass, _planePos, [], 0, "FLY"];
_plane setVelocity [sin _logicDir * CAS_SPEED, cos _logicDir * CAS_SPEED, 0];
_plane setPosASL _planePos;

private _side  = getNumber (configFile >> "CfgVehicles" >> _planeClass >> "side");
private _group = createGroup [_side call BIS_fnc_sideType, true];

createVehicleCrew _plane;
crew _plane joinSilent _group;
_group addVehicle _plane;
_group selectLeader commander _plane;

_plane disableAI "MOVE";
_plane disableAI "TARGET";
_plane disableAI "AUTOTARGET";
_plane setCombatMode "BLUE";
_plane setBehaviour "CARELESS";

_plane move ([_logicPos, CAS_DISTANCE, _logicDir] call BIS_fnc_relPos);

private _vectorDir = _planePos vectorFromTo _logicPos;
_plane setVectorDir _vectorDir;

[_plane, -90 + atan (CAS_DISTANCE / CAS_ALTITUDE), 0] call BIS_fnc_setPitchBank;
private _velocity = _vectorDir vectorMultiply CAS_SPEED;
private _vectorUp = vectorUp _plane;

// Remove weapons that will not be fired
private _weaponTypes = CAS_WEAPON_TYPES select _casType;
_weaponTypes pushBack "countermeasureslauncher";

{
    if !(toLower ((_x call BIS_fnc_itemType) select 1) in _weaponTypes) then {
        _plane removeWeapon _x;
    };
} forEach weapons _plane;

// Determine offset for weapon types
private _offset = [0, 20] select ("missilelauncher" in _weaponTypes);

[{
    params ["_logic", "_casType", "_logicPos", "_logicDir", "_plane", "_planePos", "_planeWeapons", "_vectorDir", "_vectorUp", "_velocity", "_offset", "_startTime", "_hasFired"];

    private _fireProgress = _plane getVariable [QGVAR(fireProgress), 0];
    private _fireComplete = _plane getVariable [QGVAR(fireComplete), false];

    // Update the plane's position if the module is moved or rotated and firing has not started
    if (!_hasFired && {getPosASL _logic isNotEqualTo _logicPos || {getDir _logic != _logicDir}}) then {
        _logicPos = getPosASL _logic;
        _logicDir = getDir _logic;

        _planePos = _logic getPos [CAS_DISTANCE, _logicDir + 180];
        _planePos set [2, (_logicPos select 2) + CAS_ALTITUDE];

        _vectorDir = _planePos vectorFromTo _logicPos;
        _plane setVectorDir _vectorDir;

        _velocity = _vectorDir vectorMultiply CAS_SPEED;
        _vectorUp = vectorUp _plane;

        _plane move ([_logicPos, CAS_DISTANCE, _logicDir] call BIS_fnc_relPos);

        _this set [2, _logicPos];
        _this set [3, _logicDir];
        _this set [5, _planePos];
        _this set [7, _vectorDir];
        _this set [8, _vectorUp];
        _this set [9, _velocity];

        // Broadcast direction for new CAS modules
        missionNamespace setVariable [QGVAR(casDir), _logicDir, true];
    };

    // Set the plane's approach vector, offset based weapon type and fire progress
    private _targetPos = +_logicPos;
    _targetPos set [2, (_targetPos select 2) + _offset + _fireProgress * 12];

    _plane setVelocityTransformation [
        _planePos, _targetPos,
        _velocity, _velocity,
        _vectorDir, _vectorDir,
        _vectorUp, _vectorUp,
        (CBA_missionTime - _startTime) / CAS_DURATION
    ];

    // Start firing if plane is close to the target and firing has not been started
    if (_plane distance _logicPos < 1000 && {!_hasFired}) then {
        private _targetType = ["LaserTargetE", "LaserTargetW"] select (side group _plane getFriend west > 0.6);
        private _target = createVehicle [_targetType, _logic, [], 0, "NONE"];

        _plane reveal laserTarget _target;
        _plane doWatch laserTarget _target;
        _plane doTarget laserTarget _target;

        // Prevent repeated firing start
        _this set [12, true];

        [{
            params ["_logic", "_casType", "_plane", "_planeWeapons", "_target", "_endTime", "_nextFire"];

            if (CBA_missionTime >= _nextFire) then {
                {
                    _plane fireAtTarget [_target, _x];
                } forEach _planeWeapons;

                _this set [6, _nextFire + FIRE_DELAY];
            };

            _plane setVariable [QGVAR(fireProgress), 0 max (_endTime - CBA_missionTime) / FIRE_DURATION min 1];

            isNull _logic || {isNull _plane} || {_casType == 3} || {CBA_missionTime >= _endTime}
        }, {
            params ["", "", "_plane"];

            _plane setVariable [QGVAR(fireComplete), true];
        }, [_logic, _casType, _plane, _planeWeapons, _target, CBA_missionTime + FIRE_DURATION, CBA_missionTime]] call CBA_fnc_waitUntilAndExecute;
    };

    isNull _logic || {isNull _plane} || {_fireComplete}
}, {
    params ["_logic", "", "_logicPos", "", "_plane"];

    // Cleanup plane immediately if logic was deleted
    // Otherwise wait for plane fly far enough away before deleting
    if (isNull _logic) then {
        CLEANUP_PLANE;
    } else {
        _plane flyInHeight CAS_ALTITUDE;
        deleteVehicle _logic;

        [{
            params ["_plane", "_logicPos"];

            _plane distance _logicPos > CAS_DISTANCE || {!alive _plane}
        }, {
            params ["_plane"];

            if (alive _plane) then {CLEANUP_PLANE};
        }, [_plane, _logicPos]] call CBA_fnc_waitUntilAndExecute;
    };
}, [_logic, _casType, _logicPos, _logicDir, _plane, _planePos, _planeWeapons, _vectorDir, _vectorUp, _velocity, _offset, CBA_missionTime, false]] call CBA_fnc_waitUntilAndExecute;
