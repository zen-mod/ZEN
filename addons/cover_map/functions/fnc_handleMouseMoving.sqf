#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles moving the mouse on the map.
 *
 * Arguments:
 * 0: Map <CONTROL>
 * 1: X Position <NUMBER>
 * 2: Y Position <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0.5, 0.5] call zen_cover_map_fnc_handleMouseMoving
 *
 * Public: No
 */

params ["_ctrlMap", "_posX", "_posY"];

private _position = _ctrlMap ctrlMapScreenToWorld [_posX, _posY];

// Handle moving the area if the move offset is set
private _offset = _ctrlMap getVariable QGVAR(offset);

if (!isNil "_offset") exitWith {
    // Update the center of the area based on the current position
    private _area = _ctrlMap getVariable QGVAR(area);
    _area set [0, _position vectorAdd _offset];
};

// Handle creating a new area if the anchoring corner is set
private _corner = _ctrlMap getVariable QGVAR(corner);

if (!isNil "_corner") exitWith {
    // Calculate the area's center by getting the midpoint of the diagonal end points
    private _center = _corner vectorAdd _position vectorMultiply 0.5;

    // Calculate the area's size by getting the distance between the two end points
    // Selecting first two elements since 2D vector commands return 3D vector with z = 0
    private _size = _corner vectorDiff _position apply {abs _x * 0.5} select [0, 2];

    // Store the current area, use angle of 0 while the area is being created
    // The selected rotation will be applied after the area is confirmed (release mouse button)
    _ctrlMap setVariable [QGVAR(area), [_center, _size, 0]];
};
