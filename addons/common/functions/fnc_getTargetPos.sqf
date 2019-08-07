#include "script_component.hpp"
/*
 * Author: PabstMirror, mharis001
 * Allows Zeus to click to indicate position in 3D or on map.
 * Will not overwrite currently running getTargetPos.
 * Code is passed:
 *   0: Successful <BOOL>
 *   1: Object(s) <OBJECT|ARRAY>
 *   2: Position ASL <ARRAY>
 *   3: Arguments <ANY>
 *   4: State of Shift <BOOL>
 *   5: State of Ctrl <BOOL>
 *   6: State of Alt <BOOL>
 *
 * Arguments:
 * 0: Source Object(s) <OBJECT|ARRAY>
 * 1: Code to run when position is selected <CODE>
 * 2: Arguments <ANY> (default: [])
 * 3: Text <STRING> (default: "")
 * 4: Icon File and Angle <STRING|ARRAY> (default: ["\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa", 45])
 * 5: Color <ARRAY> (default: [1, 0, 0, 1])
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, {systemChat str _this}, "Test Target"] call zen_common_fnc_getTargetPos
 *
 * Public: No
 */

// Handle only one object passed, convert to array for loops
#define GET_ARRAY(x) (if !(x isEqualType []) then {[x]} else {x})

params ["_objects", "_code", ["_args", []], ["_text", ""], ["_iconArg", [ICON_TARGET, 45]], ["_color", [1, 0, 0, 1]]];
_iconArg params ["_icon", ["_angle", 0]];

// Exit with failed if already running
if (missionNamespace getVariable [QGVAR(getTargetPosRunning), false]) exitWith {
    [false, _objects, [0, 0, 0], _args, false, false, false] call _code;
};

if (isLocalized _text) then {
    _text = localize _text;
};

GVAR(getTargetPosRunning) = true;

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;

private _mouseEH = [_display, "MouseButtonDown", {
    params ["_display", "_button", "", "", "_shift", "_ctrl", "_alt"];

    // Only watch for LMB
    if (_button != 0) exitWith {};

    private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;

    private _posASL = if (ctrlShown _ctrlMap) then {
        private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
        _pos2D + [getTerrainHeightASL _pos2D];
    } else {
        AGLtoASL screenToWorld getMousePosition;
    };

    _thisArgs params ["_objects", "_code", "_args"];
    [true, _objects, _posASL, _args, _shift, _ctrl, _alt] call _code;

    GVAR(getTargetPosRunning) = false;
}, [_objects, _code, _args]] call CBA_fnc_addBISEventHandler;


private _keyboardEH = [_display, "KeyDown", {
    params ["_display", "_key", "_shift", "_ctrl", "_alt"];

    // Only watch for ESC
    if (_key != DIK_ESCAPE) exitWith {};

    private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;

    private _posASL = if (ctrlShown _ctrlMap) then {
        private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
        _pos2D + [getTerrainHeightASL _pos2D];
    } else {
        AGLtoASL screenToWorld getMousePosition;
    };

    _thisArgs params ["_objects", "_code", "_args"];
    [false, _objects, _posASL, _args, _shift, _ctrl, _alt] call _code;

    GVAR(getTargetPosRunning) = false;
    true // handled
}, [_objects, _code, _args]] call CBA_fnc_addBISEventHandler;

private _drawEH = [_ctrlMap, "Draw", {
    params ["_ctrlMap"];
    _thisArgs params ["_objects", "_text", "_icon", "_color", "_angle"];

    private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
    private _textSize = ctrlMapScale _ctrlMap min 0.07 max 0.05;
    _ctrlMap drawIcon [_icon, _color, _pos2D, 24, 24, _angle, _text, 1, _textSize, "RobotoCondensed", "right"];

    {
        _ctrlMap drawLine [_x, _pos2D, _color];
    } forEach GET_ARRAY(_objects);
}, [_objects, _text, _icon, _color, _angle]] call CBA_fnc_addBISEventHandler;

[{
    params ["_arguments", "_pfhID"];
    _arguments params ["_objects", "_code", "_args", "_text", "_icon", "_color", "_angle", "_mouseEH", "_keyboardEH", "_drawEH"];

    // Check for null objects, Zeus display null, or interrupt display open
    if (
        GET_ARRAY(_objects) findIf {isNull _x} != -1
        || {isNull findDisplay IDD_RSCDISPLAYCURATOR}
        || {!isNull findDisplay IDD_INTERRUPT}
    ) then {
        [false, _objects, [0, 0, 0], _args, false, false, false] call _code;
        GVAR(getTargetPosRunning) = false;
    };

    // Exit if no longer running, remove EHs and PFH
    if (!GVAR(getTargetPosRunning)) exitWith {
        private _display = findDisplay IDD_RSCDISPLAYCURATOR;
        _display displayRemoveEventHandler ["MouseButtonDown", _mouseEH];
        _display displayRemoveEventHandler ["KeyDown", _keyboardEH];

        private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
        _ctrlMap ctrlRemoveEventHandler ["Draw", _drawEH];

        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };

    private _posAGL = screenToWorld getMousePosition;
    drawIcon3D [_icon, _color, _posAGL, 1.5, 1.5, _angle, _text];

    {
        drawLine3D [ASLtoAGL getPosASL _x, _posAGL, _color];
    } forEach GET_ARRAY(_objects);
}, 0, [_objects, _code, _args, _text, _icon, _color, _angle, _mouseEH, _keyboardEH, _drawEH]] call CBA_fnc_addPerFrameHandler;
