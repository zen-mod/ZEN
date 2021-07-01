#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles mouse movement for repositioning and rotating the camera.
 *
 * Arguments:
 * 0: Mouse control (not used) <CONTROL>
 * 1: Mouse X position <NUMBER>
 * 2: Mouse Y position <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0.5, 0.5] call zen_garage_fnc_handleMouse
 *
 * Public: No
 */

params ["", "_mouseX", "_mouseY"];
GVAR(mouseButtons) params ["_mouseLMB", "_mouseRMB"];

// Reposition camera when LMB held down
if (_mouseLMB isNotEqualTo []) then {
    _mouseLMB params ["_mouseLMBX", "_mouseLMBY"];

    private _deltaX = _mouseLMBX - _mouseX;
    private _deltaY = _mouseLMBY - _mouseY;
    GVAR(mouseButtons) set [0, [_mouseX, _mouseY]];

    boundingBoxReal GVAR(center) params ["_vehicleP1", "_vehicleP2"];
    _vehicleP1 params ["_vehicleX1", "_vehicleY1", "_vehicleZ1"];
    _vehicleP2 params ["_vehicleX2", "_vehicleY2", "_vehicleZ2"];
    private _vehicleSize = sqrt ([_vehicleX1, _vehicleY1] distance [_vehicleX2, _vehicleY2]);

    GVAR(helperPos) = [GVAR(helperPos), _deltaX * _vehicleSize, GVAR(camYaw) - 90] call BIS_fnc_relPos;
    GVAR(helperPos) = [
        [0, 0, ((GVAR(helperPos) select 2) - _deltaY * _vehicleSize) max _vehicleZ1 min _vehicleZ2],
        ([0,0,0] distance2D GVAR(helperPos)) min _vehicleSize,
        [0,0,0] getDir GVAR(helperPos)
    ] call BIS_fnc_relPos;

    GVAR(helperPos) set [2, (GVAR(helperPos) select 2) max (_vehicleZ1 + 0.2)];
};

// Rotate camera when RMB held down
if (_mouseRMB isNotEqualTo []) then {
    _mouseRMB params ["_mouseRMBX", "_mouseRMBY"];

    private _deltaX = (_mouseRMBX - _mouseX) * 0.75;
    private _deltaY = (_mouseRMBY - _mouseY) * 0.75;
    GVAR(mouseButtons) set [1, [_mouseX, _mouseY]];

    GVAR(helperPos) = [
        [0, 0, GVAR(helperPos) select 2],
        [0,0,0] distance2D GVAR(helperPos),
        ([0,0,0] getDir GVAR(helperPos)) - _deltaX * 360
    ] call BIS_fnc_relPos;
    GVAR(camYaw) = GVAR(camYaw) - _deltaX * 360;
    GVAR(camPitch) = (GVAR(camPitch) - _deltaY * 100) max -89 min 89;
};
