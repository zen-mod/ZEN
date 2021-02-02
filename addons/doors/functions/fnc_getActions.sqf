#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns children actions for setting the state of a door.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Actions <ARRAY>
 *
 * Example:
 * [] call zen_doors_fnc_getActions
 *
 * Public: No
 */

#define MAX_SCAN_DISTANCE 100
#define MAX_DOOR_DISTANCE 1.5

// Check if the cursor is hovering over a building's door by checking intersections from the camera
private _begPos = getPosASL curatorCamera;
private _endPos = AGLtoASL screenToWorld getMousePosition;

// Limit the intersection scan distance to prevent interaction with far away buildings
// Also improves performance of intersection test which can be expensive at long distances
if (_begPos vectorDistance _endPos > MAX_SCAN_DISTANCE) then {
    _endPos = _begPos vectorAdd (_begPos vectorFromTo _endPos vectorMultiply MAX_SCAN_DISTANCE);
};

private _intersections = lineIntersectsSurfaces [_begPos, _endPos, objNull, objNull, true, 1, "GEOM"];
_intersections param [0, []] params [["_intersectPos", [0, 0, 0]], "", ["_building", objNull]];

// Exit if there was no intersection or if it was with terrain
if (isNull _building) exitWith {
    [] // No children actions
};

// Get the door positions of the building
private _doors = [_building] call FUNC(getDoors);

// Exit if the building has no doors
if (_doors isEqualTo []) exitWith {
    [] // No children actions
};

// Calculate the distance from every door to the intersection position
private _buildingPos = _building worldToModel ASLtoAGL _intersectPos;
private _distances = _doors apply {_x vectorDistance _buildingPos};

// Exit if the closest door is too far away from the intersection position
private _minDistance = selectMin _distances;

if (_minDistance > MAX_DOOR_DISTANCE) exitWith {
    [] // No children actions
};

// Find the index of the closest door
private _door = (_distances find _minDistance) + 1;

// Create closed, locked, and opened actions for the closest door
private _actions = [];

{
    _x params ["_name", "_icon", "_state"];

    private _action = [
        format [QGVAR(%1), _state],
        _name,
        _icon,
        {
            _args call FUNC(setState);
        },
        {true},
        [_building, _door, _state]
    ] call EFUNC(context_menu,createAction);

    _actions pushBack [_action, [], 0];
} forEach [
    [TEXT_CLOSED, ICON2D_CLOSED, STATE_CLOSED],
    [TEXT_LOCKED, ICON2D_LOCKED, STATE_LOCKED],
    [TEXT_OPENED, ICON2D_OPENED, STATE_OPENED]
];

_actions
