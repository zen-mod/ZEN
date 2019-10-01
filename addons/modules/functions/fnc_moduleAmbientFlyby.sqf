#include "script_component.hpp"
/*
 * Author: mharis001, NeilZar
 * Zeus module function to create an ambient aircraft flyby.
 *
 * Arguments:
 * 0: Aircraft <STRING>
 * 1: Position <ARRAY>
 * 2: Height <NUMBER>
 * 3: Distance <NUMBER>
 * 4: Direction <NUMBER>
 * 5: Speed <NUMBER>
 * 6: Amount <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["B_Heli_Transport_03_F", [0, 0, 0], 250, 3000, 2, 1, 1] call zen_modules_fnc_moduleAmbientFlyby
 *
 * Public: No
 */

#define SPAWN_OFFSET -30

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

// Set a sufficient initial velocity for planes
private _aircraftConfig = configFile >> "CfgVehicles" >> _aircraftType;
private _simulation = getText (_aircraftConfig >> "simulation");

private _side  = getNumber (_aircraftConfig >> "side");
private _group = createGroup [_side call BIS_fnc_sideType, true];
_group allowFleeing 0;

private _aircrafts = [];

for "_i" from 0 to (_amount - 1) do {
    // Spawn aircraft at start position and set its fly direction
    private _aircraft = createVehicle [_aircraftType, _startPos, [], 0, "FLY"];
    _aircraft setPos _startPos;
    _aircraft setDir _direction;

    // set new start position -> we don't want to spawn each aircraft inside each other
    _startPos = _aircraft modelToWorld [SPAWN_OFFSET, SPAWN_OFFSET, 0];

    if (_simulation == "airplanex") then {
        _aircraft setVelocity [sin _direction * 100, cos _direction * 100, 0];
    };

    // Create the aircraft crew
    createVehicleCrew _aircraft;
    crew _aircraft joinSilent _group;
    _group addVehicle _aircraft;

    // Set the behaviour of the aircraft to the fly height and to ignore surroundings
    if (_useASL) then {
        _aircraft flyInHeight 10;
        _aircraft flyInHeightASL [_altitude, _altitude, _altitude];
    } else {
        _aircraft flyInHeight _height;
    };
    _aircraft disableAI "TARGET";
    _aircraft disableAI "AUTOTARGET";
    _aircraft setCaptive true;
    {
        _x setCaptive true;
    } forEach crew _aircraft;

    _aircrafts pushBack _aircraft;
};

_group selectLeader commander (_aircrafts select 0);

// Create a move waypoint on the end position with proper behaviour and speed
private _waypoint = _group addWaypoint [_endPos, -1];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "BLUE";
_waypoint setWaypointSpeed _speed;

// Delete aircraft, crew, and group once end waypoint is reached
_waypoint setWaypointStatements ["true", "private _group = group this; private _aircrafts = []; {if !(vehicle _x in _aircrafts) then {_aircrafts pushback vehicle _x}; deleteVehicle _x} forEach thisList; {deleteVehicle _x;} forEach _aircrafts; deleteGroup _group"];

// add aircrafts to curators
[QEGVAR(common,addObjects), [_aircrafts]] call CBA_fnc_localEvent;
