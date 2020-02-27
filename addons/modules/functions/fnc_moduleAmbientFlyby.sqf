#include "script_component.hpp"
/*
 * Author: mharis001, bux, NeilZar
 * Zeus module function to create an ambient aircraft flyby.
 *
 * Arguments:
 * 0: Aircraft <STRING>
 * 1: Position <ARRAY>
 * 2: Height Mode <BOOLEAN>
 * 3: Height <NUMBER>
 * 4: Distance <NUMBER>
 * 5: Direction <NUMBER>
 * 6: Speed <NUMBER>
 * 7: Amount <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["B_Heli_Transport_03_F", [0, 0, 0], false, 250, 3000, 2, 1, 1] call zen_modules_fnc_moduleAmbientFlyby
 *
 * Public: No
 */

#define INITIAL_VELOCITY 100
#define SIZE_COEFFICIENT 1.3

params ["_aircraftType", "_position", "_useASL", "_height", "_distance", "_direction", "_speed", "_amount"];

// Convert direction from 0 to 7 index to degrees
_direction = _direction * 45;

// Convert the given height to true altitude
private _altitude = (_position select 2) + _height;
_position = ASLToAGL _position;

// Convert speed from 0 to 2 index to speed mode
_speed = ["LIMITED", "NORMAL", "FULL"] select _speed;

// Determine start and end positions for the flyby
private _startPos = _position getPos [_distance, _direction - 180];
private _endPos   = _position getPos [_distance, _direction];

// Set position heights to be the fly height
_startPos set [2, _height];
_endPos   set [2, _height];

private _aircraftConfig = configFile >> "CfgVehicles" >> _aircraftType;
private _simulation = getText (_aircraftConfig >> "simulation");
private _side = getNumber (_aircraftConfig >> "side") call BIS_fnc_sideType;

private _aircrafts = [];
private "_spawnOffset";

private _group = createGroup [_side, true];

for "_i" from 1 to _amount do {
    // Spawn aircraft at start position and set its fly direction
    private _aircraft = createVehicle [_aircraftType, _startPos, [], 0, "FLY"];
    _aircraft setPos _startPos;
    _aircraft setDir _direction;

    // Get the size of the aircraft after at least one object of the type exists
    if (isNil "_spawnOffset") then {
        _spawnOffset = -SIZE_COEFFICIENT * sizeOf _aircraftType;
    };

    // Set new start position, we don't want to spawn aircraft inside each other
    _startPos = _aircraft modelToWorld [_spawnOffset, _spawnOffset, 0];

    // Set a sufficient initial velocity for planes
    if (_simulation == "airplanex") then {
        _aircraft setVelocity [sin _direction * INITIAL_VELOCITY, cos _direction * INITIAL_VELOCITY, 0];
    };

    // Create the aircraft crew
    createVehicleCrew _aircraft;
    crew _aircraft joinSilent _group;
    _group addVehicle _aircraft;

    // Set the fly height of the aircraft based on the mode
    if (_useASL) then {
        _aircraft flyInHeight 10;
        _aircraft flyInHeightASL [_altitude, _altitude, _altitude];
    } else {
        _aircraft flyInHeight _height;
    };

    // Set the behaviour of the crew to ignore surroundings, increase skill for better flying
    _aircraft setCaptive true;

    {
        _x disableAI "TARGET";
        _x disableAI "AUTOTARGET";
        _x disableAI "AUTOCOMBAT";
        _x setCaptive true;
        _x setSkill 1;
    } forEach crew _aircraft;

    _aircrafts pushBack _aircraft;
};

_group selectLeader commander (_aircrafts select 0);
_group allowFleeing 0;

// Create a move waypoint on the end position with proper behaviour and speed
private _waypoint = _group addWaypoint [_endPos, -1];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "BLUE";
_waypoint setWaypointSpeed _speed;

// Delete aircrafts, crews, and group once end waypoint is reached
_waypoint setWaypointStatements ["true", "private _group = group this; private _aircrafts = []; {_aircrafts pushBackUnique vehicle _x; deleteVehicle _x} forEach thisList; {deleteVehicle _x} forEach _aircrafts; deleteGroup _group"];

// Add aircrafts to curators
[QEGVAR(common,addObjects), [_aircrafts]] call CBA_fnc_serverEvent;
