#include "script_component.hpp"
/*
 * Author: Ampersand, mharis001
 * Returns a close camera view of the given object that frames the whole object,
 * ideally with its editable icon visible below it.
 *
 * The view is from behind the object, or from its front when there is clearly more room there
 * (e.g., for units standing against a wall). The camera is pulled in front of walls and ceilings
 * that would block the view.
 *
 * Arguments:
 * 0: Object <OBJECT>
 *
 * Return Value:
 * View <ARRAY>
 *   0: Camera Position ASL <ARRAY>
 *   1: Target Position ASL <ARRAY>
 *
 * Example:
 * [_object] call zen_camera_fnc_getCloseView
 *
 * Public: No
 */

// Space framed above the object (a unit's eyes) and below it, where its editable icon is drawn
#define TOP_MARGIN 0.3
#define BOTTOM_MARGIN 0.1

// Tangent of half the camera's vertical field of view, with some extra room around the framed space
#define FRAMING_TAN 0.45

// Minimum distance kept between the camera and the object's front or back end
#define MIN_END_DISTANCE 1.2

// Angle above the horizon that the camera looks down at the object from
#define ELEVATION_ANGLE 15

// Distance kept from surfaces the camera is pulled in front of
#define SURFACE_MARGIN 0.25

// Distance from the object's center when right against a surface
#define MIN_SURFACE_DISTANCE 0.1

// The view from behind is used unless it has less than this fraction of the room in front
#define CRAMPED_RATIO 0.75

params ["_object"];

0 boundingBoxReal _object params ["_p0", "_p1"];
_p0 params ["", "_p0Y", "_p0Z"];
_p1 params ["", "_p1Y", "_p1Z"];

// The bounding box does not change when a unit crouches, so a unit's eyes are used as its top instead
private _topZ = if (_object isKindOf "CAManBase") then {
    eyePos _object select 2
} else {
    _object modelToWorldVisualWorld [0, 0, _p1Z] select 2
};

private _bottomZ = _object modelToWorldVisualWorld [0, 0, _p0Z] select 2;
private _frameTopZ = _topZ + TOP_MARGIN;
private _frameBottomZ = _bottomZ - BOTTOM_MARGIN;
private _frameHalfHeight = (_frameTopZ - _frameBottomZ) / 2;

_object modelToWorldVisualWorld (_p0 vectorAdd _p1 vectorMultiply 0.5) params ["_centerX", "_centerY"];
private _targetPos = [_centerX, _centerY, _frameBottomZ + _frameHalfHeight];

// Distance at which the framed space fits in the camera's view, while staying clear of the object's ends
// The camera looks along the object's length, which matters for long objects and prone units
private _halfLength = (_p1Y - _p0Y) / 2;
private _idealDistance = (_frameHalfHeight / FRAMING_TAN) max (_halfLength + MIN_END_DISTANCE);

// Returns the camera position looking at the target from the given heading, and its distance from the target
private _fnc_getCameraPos = {
    params ["_heading"];

    // Direction from the target back to the camera, which is behind and above the target from the given heading
    private _targetToCameraDir = [
        -cos ELEVATION_ANGLE * sin _heading,
        -cos ELEVATION_ANGLE * cos _heading,
        sin ELEVATION_ANGLE
    ];

    private _idealCameraPos = _targetPos vectorAdd (_targetToCameraDir vectorMultiply _idealDistance);

    // Fire geometry includes windows, so the camera stays inside the room instead of looking in through them
    private _intersections = lineIntersectsSurfaces [
        _targetPos, _idealCameraPos, _object, objNull, true, 1, "FIRE", "GEOM"
    ];

    if (_intersections isEqualTo []) exitWith {
        [_idealCameraPos, _idealDistance]
    };

    _intersections select 0 params ["_surfacePos"];

    private _adjustedDistance = (_targetPos vectorDistance _surfacePos) - SURFACE_MARGIN max MIN_SURFACE_DISTANCE;
    private _cameraPos = _targetPos vectorAdd (_targetToCameraDir vectorMultiply _adjustedDistance);

    [_cameraPos, _adjustedDistance]
};

private _heading = getDirVisual _object;
[_heading] call _fnc_getCameraPos params ["_behindCameraPos", "_behindDistance"];
[_heading + 180] call _fnc_getCameraPos params ["_frontCameraPos", "_frontDistance"];

// Look at the object's front when the view from behind is cramped (e.g., units standing against a wall)
private _isBehindCramped = _behindDistance < CRAMPED_RATIO * _frontDistance;
private _cameraPos = [_behindCameraPos, _frontCameraPos] select _isBehindCramped;

[_cameraPos, _targetPos]
