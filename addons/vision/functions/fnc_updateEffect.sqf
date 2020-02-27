#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles enabling and adjusting the NVG brightness effect.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_vision_fnc_updateEffect
 *
 * Public: No
 */

private _ppBrightness = missionNamespace getVariable [QGVAR(ppBrightness), -1];

// Exit if curator camera not active
if (isNull curatorCamera) exitWith {
    _ppBrightness ppEffectEnable false;
};

// Exit if current vision mode is not NVG
private _curator = getAssignedCuratorLogic player;
private _modes = _curator call BIS_fnc_curatorVisionModes;
private _index = _curator getVariable ["BIS_fnc_curatorVisionModes_current", 0];

if (_modes select _index != -2) exitWith {
    _ppBrightness ppEffectEnable false;
};

// Convert current brightness level to effect contrast value
private _brightness = missionNamespace getVariable [QGVAR(brightness), 0];
private _contrast   = linearConversion [MIN_BRIGHTNESS, MAX_BRIGHTNESS, _brightness, MIN_CONTRAST, MAX_CONTRAST, true];

// Enable and adjust effect
_ppBrightness ppEffectEnable true;
_ppBrightness ppEffectAdjust [1, _contrast, 0, [0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 1]];
_ppBrightness ppEffectCommit 0;
