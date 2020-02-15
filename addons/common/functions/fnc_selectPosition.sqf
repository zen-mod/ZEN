#include "script_component.hpp"
/*
 * Author: PabstMirror, mharis001
 * Allows Zeus to select a position by clicking in the world or on the map.
 * Will not overwrite an already active instance.
 *
 * The Selection Code is called when a position is successfully selected or failure
 * occurs due to one of the following conditions:
 *   - aborted by pressing ESCAPE or opening pause menu.
 *   - one or more of the given objects was deleted.
 *   - closing the Zeus display.
 *
 * The Selection Code is passed the following:
 *   0: Successful <BOOL>
 *   1: Object(s) <OBJECT|ARRAY>
 *   2: Position ASL <ARRAY>
 *   3: Arguments <ANY>
 *   4: Shift State <BOOL>
 *   5: Control State <BOOL>
 *   6: Alt State <BOOL>
 *
 * The Modifier Function allows the visual properties to be dynamically changed every frame.
 * On each call, this code can modify the passed draw arguments array by reference.
 *
 * The Modifier Function is passed the following:
 *   0: Object(s) <OBJECT|ARRAY>
 *   1: Position ASL <ARRAY>
 *   2: Arguments <ANY>
 *   3: Draw Arguments <ARRAY>
 *     0: Text <STRING>
 *     1: Icon <STRING>
 *     2: Icon Angle <NUMBER>
 *     4: Color <ARRAY>
 *
 * Arguments:
 * 0: Object(s) <OBJECT|ARRAY>
 * 1: Selection Code <CODE>
 * 2: Arguments <ANY> (default: [])
 * 3: Text <STRING> (default: "")
 * 4: Icon File and Angle <STRING|ARRAY> (default: ["\a3\ui_f\data\igui\cfg\cursors\select_target_ca.paa", 45])
 * 5: Color <ARRAY> (default: [1, 0, 0, 1])
 * 6: Modifier Function <CODE> (default: {})
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, {systemChat str _this}, "Test", "Target"] call zen_common_fnc_selectPosition
 *
 * Public: No
 */

// Handle only one object passed, convert to array for loops
#define GET_ARRAY(x) (if (x isEqualType []) then {x} else {[x]})

params ["_objects", "_code", ["_args", []], ["_text", ""], ["_iconArg", [ICON_TARGET, 45]], ["_color", [1, 0, 0, 1]], ["_modifierFnc", {}]];
_iconArg params [["_icon", ""], ["_angle", 0]];

private _display = findDisplay IDD_RSCDISPLAYCURATOR;

// Exit with failure if an instance is already active or Zeus display is not open
if (GVAR(selectPositionActive) || {isNull _display}) exitWith {
    [false, _objects, [0, 0, 0], _args, false, false, false] call _code;
};

GVAR(selectPositionActive) = true;

private _drawArgs = [_text, _icon, _angle, _color];
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;

private _mouseEH = [_display, "MouseButtonDown", {
    params ["_display", "_button", "", "", "_shift", "_ctrl", "_alt"];

    // Only watch for LMB
    if (_button != 0) exitWith {};

    private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    private _posASL = [] call FUNC(getPosFromScreen);

    _thisArgs params ["_objects", "_code", "_args"];
    [true, _objects, _posASL, _args, _shift, _ctrl, _alt] call _code;

    GVAR(selectPositionActive) = false;
}, [_objects, _code, _args]] call CBA_fnc_addBISEventHandler;

private _keyboardEH = [_display, "KeyDown", {
    params ["_display", "_key", "_shift", "_ctrl", "_alt"];

    // Only watch for ESCAPE
    if (_key != DIK_ESCAPE) exitWith {false};

    private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    private _posASL = [] call FUNC(getPosFromScreen);

    _thisArgs params ["_objects", "_code", "_args"];
    [false, _objects, _posASL, _args, _shift, _ctrl, _alt] call _code;

    GVAR(selectPositionActive) = false;

    true // handled
}, [_objects, _code, _args]] call CBA_fnc_addBISEventHandler;

private _drawEH = [_ctrlMap, "Draw", {
    params ["_ctrlMap"];
    _thisArgs params ["_objects", "_args", "_drawArgs", "_modifierFnc"];

    private _posASL = [] call FUNC(getPosFromScreen);
    [_objects, _posASL, _args, _drawArgs] call _modifierFnc;
    _drawArgs params ["_text", "_icon", "_angle", "_color"];

    if (isLocalized _text) then {
        _text = localize _text;
    };

    private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
    private _textSize = 0.05 max ctrlMapScale _ctrlMap min 0.07;

    _ctrlMap drawIcon [_icon, _color, _pos2D, 24, 24, _angle, _text, 0, _textSize, "RobotoCondensed", "right"];

    {
        _ctrlMap drawLine [_x, _pos2D, _color];
    } forEach GET_ARRAY(_objects);
}, [_objects, _args, _drawArgs, _modifierFnc]] call CBA_fnc_addBISEventHandler;

[{
    params ["_arguments", "_pfhID"];
    _arguments params ["_objects", "_code", "_args", "_drawArgs", "_modifierFnc", "_mouseEH", "_keyboardEH", "_drawEH"];

    // End selection with failure if an object is deleted, Zeus display is closed, or pause menu is opened
    if (
        GET_ARRAY(_objects) findIf {isNull _x} != -1
        || {isNull findDisplay IDD_RSCDISPLAYCURATOR}
        || {!isNull findDisplay IDD_INTERRUPT}
    ) then {
        [false, _objects, [0, 0, 0], _args, false, false, false] call _code;
        GVAR(selectPositionActive) = false;
    };

    // Exit if selection is no longer active, remove added event handlers and this PFH
    if (!GVAR(selectPositionActive)) exitWith {
        private _display = findDisplay IDD_RSCDISPLAYCURATOR;
        _display displayRemoveEventHandler ["MouseButtonDown", _mouseEH];
        _display displayRemoveEventHandler ["KeyDown", _keyboardEH];

        private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
        _ctrlMap ctrlRemoveEventHandler ["Draw", _drawEH];

        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };

    // No 3D drawing needed if the map is visible
    if (visibleMap) exitWith {};

    private _posASL = [] call FUNC(getPosFromScreen);
    [_objects, _posASL, _args, _drawArgs] call _modifierFnc;
    _drawArgs params ["_text", "_icon", "_angle", "_color"];

    if (isLocalized _text) then {
        _text = localize _text;
    };

    private _posAGL = ASLtoAGL _posASL;

    drawIcon3D [_icon, _color, _posAGL, 1.5, 1.5, _angle, _text];

    {
        drawLine3D [ASLtoAGL getPosASL _x, _posAGL, _color];
    } forEach GET_ARRAY(_objects);
}, 0, [_objects, _code, _args, _drawArgs, _modifierFnc, _mouseEH, _keyboardEH, _drawEH]] call CBA_fnc_addPerFrameHandler;
