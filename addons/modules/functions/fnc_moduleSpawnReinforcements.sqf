#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to spawn reinforcements.
 * Infantry behaviour: 0 - default, 1 - relaxed, 2 - cautious, 3 - combat.
 * Insertion method (only for air vehicles): 0 - land, 1 - paradrop, 2 - fastrope.
 *
 * Arguments:
 * 0: Vehicle Type <STRING>
 * 1: Infantry Types <ARRAY>
 * 2: Spawn Position <ARRAY>
 * 3: LZ Position <ARRAY>
 * 4: RP Position <ARRAY>
 * 5: RTB and Despawn <BOOL>
 * 6: Infantry Behaviour <NUMBER>
 * 7: Insertion Method <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_modules_fnc_moduleSpawnReinforcements
 *
 * Public: No
 */

#define AIRCRAFT_HEIGHT 100
#define WAYPOINT_RADIUS 30

params ["_vehicleType", "_infantryTypes", "_spawnPosition", "_lzPosition", "_rpPosition", "_despawnVehicle", "_unitBehaviour", "_insertionMethod"];

// Determine the direction the vehicle should face on spawn
private _direction = _spawnPosition getDir _lzPosition;

// Adjust spawn position for air vehicles
private _isAir = _vehicleType isKindOf "Air";
private _placement = "NONE";

if (_isAir) then {
    _spawnPosition set [2, AIRCRAFT_HEIGHT];
    _placement = "FLY";
};

// Spawn vehicle at the start position and set its direction
private _vehicle = createVehicle [_vehicleType, _spawnPosition, [], 0, _placement];
_vehicle setDir _direction;

private _vehicleConfig = configFile >> "CfgVehicles" >> _vehicleType;

// Set a sufficient initial velocity for planes
if (getText (_vehicleConfig >> "simulation") == "airplanex") then {
    _vehicle setVelocity [sin _direction * 100, cos _direction * 100, 0];
};

// Determine the side of the units from the vehicle
private _side = [getNumber (_vehicleConfig >> "side")] call BIS_fnc_sideType;

// Create the vehicle crew
private _vehicleGroup = createGroup [_side, true];
createVehicleCrew _vehicle;

crew _vehicle joinSilent _vehicleGroup;
_vehicleGroup addVehicle _vehicle;

_vehicleGroup selectLeader commander _vehicle;
_vehicleGroup allowFleeing 0;

// Force aircraft to fly at the correct height and ignore surroundings
if (_isAir) then {
    _vehicleGroup setBehaviour "CARELESS";
    _vehicle flyInHeight AIRCRAFT_HEIGHT;
};

// Increase the skill of the driver/pilot for better driving/flying
driver _vehicle setSkill 1;

// Spawn the infantry units and move them into the vehicle's cargo positions
private _infantryGroup = createGroup [_side, true];

{
    private _unit = _infantryGroup createUnit [_x, [0, 0, 0], [], 0, "CAN_COLLIDE"];
    _unit moveInCargo _vehicle;
} forEach _infantryTypes;

// Add waypoint to make vehicle drop units off at the LZ
// Handle insertion mode parameter for air vehicles
private _waypoint = _vehicleGroup addWaypoint [_lzPosition, WAYPOINT_RADIUS];

// Use normal transport unload if fastroping is not available
if (_insertionMethod == 2 && {!isClass (configFile >> "CfgPatches" >> "ace_fastroping") || {getNumber (_vehicleConfig >> "ace_fastroping_enabled") == 0}}) then {
    _insertionMethod = 0;
};

if (_isAir && {_insertionMethod > 0}) then {
    _waypoint setWaypointType "SCRIPTED";

    private _script = [
        QPATHTOEF(ai,functions\fnc_waypointParadrop.sqf),
        QPATHTOEF(ai,functions\fnc_waypointFastrope.sqf)
    ] select (_insertionMethod == 2);

    _waypoint setWaypointScript _script;
} else {
    _waypoint setWaypointType "TR UNLOAD";
};

// Add waypoint to make infantry units move to RP after they arrive at LZ
if !(_rpPosition isEqualTo []) then {
    _infantryGroup addWaypoint [_rpPosition, WAYPOINT_RADIUS];
};

// Adjust behaviour of infantry units if not default
if (_unitBehaviour > 0) then {
    private _behaviour = ["SAFE", "AWARE", "COMBAT"] select (_unitBehaviour - 1);
    private _speedMode = ["LIMITED", "NORMAL"] select (_unitBehaviour > 1);

    _infantryGroup setBehaviour _behaviour;
    _infantryGroup setSpeedMode _speedMode;
};

// Add waypoint to make vehicle return to spawn position and despawn if needed
if (_despawnVehicle) then {
    private _waypointRTB = _vehicleGroup addWaypoint [_spawnPosition, WAYPOINT_RADIUS];
    _waypointRTB setWaypointStatements ["true", "deleteVehicle vehicle this; {deleteVehicle _x} forEach thisList"];
};

// Add the vehicle and crew + passengers to curators
[QEGVAR(common,addObjects), [[_vehicle]]] call CBA_fnc_localEvent;
