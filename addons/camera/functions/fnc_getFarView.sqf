#include "script_component.hpp"
/*
 * Author: Ampersand, mharis001
 * Returns a far camera view that looks at the given object from above and behind, at a distance
 * based on its size. When something blocks the line of sight, the view swings around the object
 * to the nearest clear angle.
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
 * [_object] call zen_camera_fnc_getFarView
 *
 * Public: No
 */

// Distance from the object's center as a multiple of its bounding radius
#define DISTANCE_COEF 3

// Minimum distance from the object's center (for small objects)
#define MIN_DISTANCE 20

// Angle above the horizon that the camera looks down at the object from
#define ELEVATION_ANGLE 30

// Heading offsets from behind the object, tried in order when the line of sight is blocked
#define HEADING_OFFSETS [0, 30, -30, 60, -60, 90, -90, 120, -120, 150, -150, 180]

// Minimum height of the camera above the terrain, and above the sea for objects that are not underwater
#define MIN_HEIGHT 2

// Minimum depth of the camera below the sea surface for underwater objects
#define MIN_DEPTH 1

params ["_object"];

0 boundingBoxReal _object params ["_p0", "_p1"];

private _targetPos = _object modelToWorldVisualWorld (_p0 vectorAdd _p1 vectorMultiply 0.5);
private _distance = DISTANCE_COEF * (_p0 vectorDistance _p1) / 2 max MIN_DISTANCE;
private _heading = getDirVisual _object;

// Underwater objects can barely be seen through the sea surface, so the camera is kept below it
private _isUnderwater = _object modelToWorldVisualWorld [0, 0, _p1 select 2] select 2 < 0;

// Returns the camera position looking at the target from the given heading, kept above the terrain
// and on the same side of the sea surface as the object
private _fnc_getCameraPos = {
    params ["_heading"];

    private _cameraPos = _targetPos vectorAdd [
        -(_distance * cos ELEVATION_ANGLE) * sin _heading,
        -(_distance * cos ELEVATION_ANGLE) * cos _heading,
        _distance * sin ELEVATION_ANGLE
    ];

    _cameraPos params ["_cameraPosX", "_cameraPosY", "_cameraPosZ"];
    private _terrainHeight = getTerrainHeightASL _cameraPos;

    // In shallow water, staying below the sea surface takes priority over the height above the seabed
    if (_isUnderwater) then {
        _cameraPosZ = _cameraPosZ max (_terrainHeight + MIN_HEIGHT) min -MIN_DEPTH;
    } else {
        _cameraPosZ = _cameraPosZ max ((0 max _terrainHeight) + MIN_HEIGHT);
    };

    [_cameraPosX, _cameraPosY, _cameraPosZ]
};

private "_cameraPos";

{
    private _candidateCameraPos = [_heading + _x] call _fnc_getCameraPos;

    // Keep the first position as a fallback
    if (isNil "_cameraPos") then {
        _cameraPos = _candidateCameraPos;
    };

    // Use the first position with a clear view of the object
    private _isViewClear = lineIntersectsSurfaces [
        _candidateCameraPos, _targetPos, _object, objNull, true, 1, "VIEW", "GEOM"
    ] isEqualTo [];

    if (_isViewClear) exitWith {
        _cameraPos = _candidateCameraPos;
    };
} forEach HEADING_OFFSETS;

[_cameraPos, _targetPos]
