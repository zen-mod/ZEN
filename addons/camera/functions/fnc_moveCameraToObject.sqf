#include "script_component.hpp"
/*
 * Author: Ampersand, mharis001
 * Moves the curator camera to the given view of an object.
 *
 * While the move camera key is held, the camera follows the object and keeps looking at it.
 * The camera's regular movement (e.g., WASD) still works and is applied relative to the object,
 * so the camera can be moved around the object while following it.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: View <ARRAY>
 *   0: Camera Position ASL <ARRAY>
 *   1: Target Position ASL <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, [[0, 0, 10], [0, 10, 0]]] call zen_camera_fnc_moveCameraToObject
 *
 * Public: No
 */

params ["_object", "_view"];
_view params ["_cameraPos", "_targetPos"];

private _fnc_setCamera = {
    params ["_cameraPos", "_targetPos"];

    curatorCamera setPosASL _cameraPos;

    // Keep the current direction when the camera is on the target, where there is nothing to look at
    if (_cameraPos vectorDistance _targetPos > 0.05) then {
        private _cameraDir = _cameraPos vectorFromTo _targetPos;
        private _cameraUp = _cameraDir vectorCrossProduct [0, 0, 1] vectorCrossProduct _cameraDir;
        curatorCamera setVectorDirAndUp [_cameraDir, _cameraUp];
    };
};

[_cameraPos, _targetPos] call _fnc_setCamera;

private _origin = getPosWorldVisual _object;
private _cameraOffset = _cameraPos vectorDiff _origin;
private _targetOffset = _targetPos vectorDiff _origin;

[{
    params ["_object", "_cameraOffset", "_targetOffset", "_lastCameraPos", "_fnc_setCamera"];

    // The key up event is missed when the game loses focus while the key is held
    if (!isGameFocused) then {
        GVAR(moveCameraKeyHeld) = false;
    };

    if (
        !GVAR(moveCameraKeyHeld)
        || {isNull _object}
        || {isNull curatorCamera}
    ) exitWith {
        true // Exit
    };

    // Moving the camera since the last frame changes its offset from the object
    _cameraOffset = _cameraOffset vectorAdd (getPosASL curatorCamera vectorDiff _lastCameraPos);

    private _origin = getPosWorldVisual _object;
    private _cameraPos = _origin vectorAdd _cameraOffset;
    private _targetPos = _origin vectorAdd _targetOffset;
    [_cameraPos, _targetPos] call _fnc_setCamera;

    _this set [1, _cameraOffset];
    _this set [3, _cameraPos];

    false // Continue
}, {}, [_object, _cameraOffset, _targetOffset, _cameraPos, _fnc_setCamera]] call CBA_fnc_waitUntilAndExecute;
