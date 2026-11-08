#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the position where the ray from the Zeus camera through the given
 * screen position intersects the plane defined by a point and normal.
 *
 * Arguments:
 * 0: Screen Position <ARRAY> (default: getMousePosition)
 * 1: Point on Plane ASL <ARRAY>
 * 2: Plane Normal <ARRAY>
 *
 * Return Value:
 * Position ASL <ARRAY>
 *   - Empty array if the ray is parallel to the plane or the plane is behind the camera.
 *
 * Example:
 * [[0.5, 0.5], [0, 0, 10], [0, 0, 1]] call zen_common_fnc_getPosFromScreenOnPlane
 *
 * Public: No
 */

params [
    ["_screenPos", getMousePosition, [[]], 2],
    ["_planePos", [0, 0, 0], [[]], 3],
    ["_planeNormal", [0, 0, 1], [[]], 3]
];

private _cameraPos = getPosASL curatorCamera;
private _rayDir = screenToWorldDirection _screenPos;

// The ray never meets the plane when it is parallel to it
private _rayDotNormal = _rayDir vectorDotProduct _planeNormal;
if (_rayDotNormal == 0) exitWith {[]};

// The plane is behind the camera when the distance along the ray is negative
private _distance = (_planePos vectorDiff _cameraPos vectorDotProduct _planeNormal) / _rayDotNormal;
if (_distance < 0) exitWith {[]};

_cameraPos vectorAdd (_rayDir vectorMultiply _distance)
