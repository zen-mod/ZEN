#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the position along the ray from the Zeus camera through the given screen position that is at
 * the given height above the surface (terrain or sea), objects are ignored and positions behind the terrain
 * are not considered. When the ray is at the height at several distances, the one nearest to the given
 * current position along the ray is used, otherwise the first one from the camera.
 *
 * Arguments:
 * 0: Screen Position <ARRAY> (default: getMousePosition)
 * 1: Height Above Surface <NUMBER> (default: 0)
 * 2: Current Position ASL <ARRAY> (default: [])
 *   - Empty array for no preference, the first position from the camera is used.
 *
 * Return Value:
 * Position ASL <ARRAY>
 *   - Empty array if the ray is never at the height (e.g., when aimed at the sky).
 *
 * Example:
 * [[0.5, 0.5], 10, [0, 0, 10]] call zen_common_fnc_getPosFromScreenAtHeight
 *
 * Public: No
 */

// The search steps outward from the current position's distance along the ray
// The steps start at one terrain cell, so the ray rarely dips below the surface and back above it between
// two steps, and grow so the search reaches far from the current position while staying fine near it
#define SEARCH_DISTANCE 1000
#define SEARCH_STEP_GROWTH 1.12

// Positions closer to the surface than this count as on it
#define SURFACE_TOLERANCE 0.01

params [
    ["_screenPos", getMousePosition, [[]], 2],
    ["_height", 0, [0]],
    ["_currentPos", [], [[]], [0, 3]]
];

private _cameraPos = getPosASL curatorCamera;
private _rayDir = screenToWorldDirection _screenPos;

// The ray is at the height above the surface where the same ray lowered by the height meets the surface
private _loweredCameraPos = _cameraPos vectorDiff [0, 0, _height];

// Positions behind the terrain hit are hidden, so it ends the search
private _farPos = _cameraPos vectorAdd (_rayDir vectorMultiply viewDistance);
private _terrainHitPos = terrainIntersectAtASL [_cameraPos, _farPos];
private _hasTerrainHit = _terrainHitPos isNotEqualTo [0, 0, 0];
private _maxDistance = [viewDistance, _cameraPos vectorDistance _terrainHitPos] select _hasTerrainHit;

// Without a height, the terrain hit is the only position on the surface in front of it and is used as is
// since a cast along a shorter part of the ray can land centimeters from it at long distances
if (_hasTerrainHit && {abs _height < SURFACE_TOLERANCE}) exitWith {_terrainHitPos};

// Checks if the lowered ray is above the surface at the given distance
// It counts as below it from the terrain hit onwards even if the surface height says otherwise
private _fnc_isAboveSurface = {
    params ["_distance"];

    private _rayPos = _loweredCameraPos vectorAdd (_rayDir vectorMultiply _distance);
    private _surfaceHeight = 0 max getTerrainHeightASL _rayPos;
    _rayPos select 2 > _surfaceHeight && {!_hasTerrainHit || {_distance < _maxDistance}}
};

// Returns the distance between the given ones where the lowered ray crosses the surface (-1 if it does not)
private _fnc_findCrossing = {
    params ["_distance1", "_distance2", "_isAbove1", "_isAbove2"];

    if (_isAbove1 isEqualTo _isAbove2) exitWith {-1};

    // Casting from the end above the surface works for crossings in both directions and never starts below it
    private _fromDistance = [_distance2, _distance1] select _isAbove1;
    private _toDistance = [_distance1, _distance2] select _isAbove1;
    private _fromPos = _loweredCameraPos vectorAdd (_rayDir vectorMultiply _fromDistance);
    private _toPos = _loweredCameraPos vectorAdd (_rayDir vectorMultiply _toDistance);
    private _hitPos = terrainIntersectAtASL [_fromPos, _toPos];

    // The cast also stops at the sea's surface, but not precisely on short casts,
    // so that crossing is calculated instead
    if (_hitPos isNotEqualTo [0, 0, 0]) exitWith {
        if (getTerrainHeightASL _hitPos < 0) then {
            (_loweredCameraPos select 2) / -(_rayDir select 2)
        } else {
            _hitPos vectorDiff _loweredCameraPos vectorDotProduct _rayDir
        };
    };

    // A miss next to the terrain hit means the cast ended just short of it,
    // otherwise the surface height was imprecise
    [-1, _maxDistance] select (_hasTerrainHit && {_toDistance == _maxDistance})
};

private _distance = -1;

// Searching outward from the current position's distance keeps the current position in place when several
// distances are valid (e.g., after being raised above a far hill with a nearer hill reaching its height
// in front of it)
if (_currentPos isNotEqualTo []) then {
    private _currentDistance = _currentPos vectorDiff _cameraPos vectorDotProduct _rayDir;
    private _startDistance = 0 max _currentDistance min _maxDistance;

    // Already at the height (e.g., while the mouse is still), kept since a cast ending this close
    // to the surface can miss it and lead the search to another distance
    private _startPos = _loweredCameraPos vectorAdd (_rayDir vectorMultiply _startDistance);
    private _surfaceHeight = 0 max getTerrainHeightASL _startPos;

    if (abs ((_startPos select 2) - _surfaceHeight) < SURFACE_TOLERANCE) exitWith {
        _distance = _startDistance;
    };

    private _isForwardAbove = [_startDistance] call _fnc_isAboveSurface;
    private _isBackwardAbove = _isForwardAbove;
    private _stepSize = getTerrainInfo select 2;
    private _offset = 0;

    while {_distance < 0 && {_offset < SEARCH_DISTANCE}} do {
        private _nextOffset = _offset + _stepSize;

        if (_startDistance + _offset < _maxDistance) then {
            private _nearDistance = _startDistance + _offset;
            private _farDistance = (_startDistance + _nextOffset) min _maxDistance;
            private _isFarAbove = [_farDistance] call _fnc_isAboveSurface;
            _distance = [_nearDistance, _farDistance, _isForwardAbove, _isFarAbove] call _fnc_findCrossing;
            _isForwardAbove = _isFarAbove;
        };

        if (_startDistance - _offset > 0 && {_distance < 0}) then {
            private _nearDistance = _startDistance - _offset;
            private _farDistance = (_startDistance - _nextOffset) max 0;
            private _isFarAbove = [_farDistance] call _fnc_isAboveSurface;
            _distance = [_nearDistance, _farDistance, _isBackwardAbove, _isFarAbove] call _fnc_findCrossing;
            _isBackwardAbove = _isFarAbove;
        };

        _offset = _nextOffset;
        _stepSize = _stepSize * SEARCH_STEP_GROWTH;
    };
};

// No crossing near the current position (or none given), use the first one from the camera
// The cast cannot find it when it starts below the surface (i.e., the camera is lower than the height)
if (_distance < 0 && {0 call _fnc_isAboveSurface}) then {
    _distance = [0, _maxDistance, true, false] call _fnc_findCrossing;
};

if (_distance < 0) exitWith {[]};

_cameraPos vectorAdd (_rayDir vectorMultiply _distance)
