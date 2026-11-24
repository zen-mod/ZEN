#include "script_component.hpp"
/*
 * Author: Ampersand, mharis001
 * Handles the key down event for the Zeus display.
 *
 * Arguments:
 * 0: Display (not used) <DISPLAY>
 * 1: Key Code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, 0] call zen_camera_fnc_handleKeyDown
 *
 * Public: No
 */

// Bounding box diagonal of the largest objects that have a close view, besides units
#define MAX_CLOSE_VIEW_SIZE 5

params ["", "_keyCode"];

if (
    GVAR(moveCameraMode) == MOVE_CAMERA_MODE_ENHANCED
    && {_keyCode in actionKeys "curatorMoveCamTo"}
    && {inputAction "curatorLockCameraTo" == 0}
    && {SELECTED_OBJECTS isNotEqualTo []}
    && {!GETMVAR(RscDisplayCurator_search,false)}
) exitWith {
    // Ignore repeated events while the key is held
    if (GVAR(moveCameraKeyHeld)) exitWith {true};

    private _object = SELECTED_OBJECTS select 0;
    private _objectParent = objectParent _object;

    // Units inside vehicles are viewed through their vehicle
    if (!isNull _objectParent) then {
        _object = _objectParent;
    };

    0 boundingBoxReal _object params ["_p0", "_p1"];

    // Units and small objects have a close view, which is switched to and from on repeated activations
    // These are recognized by the camera not having been moved or rotated since, even if the object has moved
    private _isClose = (
        _object isKindOf "CAManBase" || {_p0 vectorDistance _p1 <= MAX_CLOSE_VIEW_SIZE}
    ) && {
        GVAR(previousMove) params [
            ["_previousObject", objNull],
            ["_previousIsClose", false],
            ["_previousCameraPos", [0, 0, 0]],
            ["_previousCameraDir", [0, 0, 0]]
        ];

        private _isRepeat = _object == _previousObject
            && {getPosASL curatorCamera vectorDistance _previousCameraPos < 0.1}
            && {vectorDir curatorCamera vectorDotProduct _previousCameraDir > 0.9999};

        if (_isRepeat) then {
            !_previousIsClose
        } else {
            // Start with the close view for objects under a roof, which would hide them from the far view
            private _begPos = _object modelToWorldVisualWorld [0, 0, _p1 select 2];
            private _endPos = _begPos vectorAdd [0, 0, 50];
            lineIntersectsSurfaces [_begPos, _endPos, _object, objNull, true, 1, "GEOM", "NONE"] isNotEqualTo []
        };
    };

    private _view = if (_isClose) then {
        [_object] call FUNC(getCloseView)
    } else {
        [_object] call FUNC(getFarView)
    };

    [_object, _view] call FUNC(moveCameraToObject);

    GVAR(moveCameraKeyHeld) = true;
    GVAR(previousMove) = [_object, _isClose, getPosASL curatorCamera, vectorDir curatorCamera];

    true // handled
};

false
