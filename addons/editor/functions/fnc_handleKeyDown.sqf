#include "script_component.hpp"
/*
 * Author: mharis001, Ampersand
 * Handles the key down event for the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Key Code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, 0] call zen_editor_fnc_handleKeyDown
 *
 * Public: No
 */

params ["_display", "_keyCode"];

if (
    GVAR(moveCamToSelection) > 0
    && {inputAction "curatorLockCameraTo" == 0}
    && {_keyCode in actionKeys "curatorMoveCamTo"}
    && {count SELECTED_OBJECTS > 0}
) exitWith {
    [] call FUNC(moveCamToSelection);

    true
};

if (_keyCode in actionKeys "curatorPingView" && {!isNil QGVAR(pingTarget)} && {isNil QGVAR(pingViewed)}) exitWith {
    if (GVAR(pingTarget) isEqualType objNull) then {
        private _distance = 0.5 * sizeOf typeOf GVAR(pingTarget) max 25;
        private _position = GVAR(pingTarget) modelToWorldWorld [0, -_distance, 0.8 * _distance];
        curatorCamera setPosASL _position;
        curatorCamera camSetTarget GVAR(pingTarget);
        curatorCamera camCommit 0;
        curatorCamera camSetTarget objNull;
        curatorCamera camCommit 0;
    } else {
        private _camPos = ASLToAGL getPosASL curatorCamera;
        private _camDir = getDir curatorCamera;
        private _height = (_camPos select 2) max 5;
        private _distance = _height * 2;
        private _position = GVAR(pingTarget) getPos [_distance, _camDir + 180];
        _position set [2, _height + (GVAR(pingTarget) select 2)];

        // Workaround for being unable to set a position as the curator camera's target
        // Essentially, an unscheduled equivalent of BIS_fnc_setCuratorCamera
        private _camera = "camera" camCreate _position;
        _camera cameraEffect ["Internal", "BACK"];
        _camera camPrepareTarget GVAR(pingTarget);
        _camera camCommitPrepared 0;

        [{
            camCommitted _this
        }, {
            [{
                curatorCamera setPosASL getPosASL _this;
                curatorCamera setVectorDirAndUp [vectorDir _this, vectorUp _this];

                _this cameraeffect ["Terminate", "BACK"];
                curatorCamera cameraEffect ["Internal", "BACK"];
                cameraEffectEnableHUD true;
                camDestroy _this;
            }, _this] call CBA_fnc_execNextFrame;
        }, _camera] call CBA_fnc_waitUntilAndExecute;
    };

    GVAR(pingViewed) = true;

    true // handled
};

// One frame later so RscDisplayCurator_sections is updated
[{
    params ["_display", "_keyCode", "_oldMode"];

    if (_keyCode == DIK_TAB) then {
        RscDisplayCurator_sections params ["_mode", "_side"];

        if (_mode != _oldMode) then {
            [QGVAR(modeChanged), [_display, _mode, _side]] call CBA_fnc_localEvent;
        };
    };
}, [_display, _keyCode, RscDisplayCurator_sections select 0]] call CBA_fnc_execNextFrame;

false
