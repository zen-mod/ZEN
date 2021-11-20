#include "script_component.hpp"
/*
 * Author: PabstMirror, mharis001
 * Allows Zeus to select a position by clicking in the world or on the map.
 * Will not overwrite an already active instance.
 *
 * The function is called when a position is successfully selected or failure
 * occurs due to one of the following conditions:
 *   - aborted by pressing ESCAPE or opening pause menu.
 *   - one or more of the given objects was deleted.
 *   - closing the Zeus display.
 *
 * The function is passed the following:
 *   0: Successful <BOOL>
 *   1: Object(s) <OBJECT|ARRAY>
 *   2: Position ASL <ARRAY>
 *   3: Arguments <ANY>
 *   4: Shift State <BOOL>
 *   5: Control State <BOOL>
 *   6: Alt State <BOOL>
 *
 * The modifier function allows the visual properties to be dynamically changed every frame.
 * On each call, this code can modify the passed visual properties array by reference.
 *
 * The modifier function is passed the following:
 *   0: Object(s) <OBJECT|ARRAY>
 *   1: Position ASL <ARRAY>
 *   2: Arguments <ANY>
 *   3: Visual Properties <ARRAY>
 *     0: Text <STRING>
 *     1: Icon <STRING>
 *     2: Icon Angle <NUMBER>
 *     4: Color <ARRAY>
 *
 * Arguments:
 * 0: Object(s) <OBJECT|ARRAY>
 * 1: Function <CODE>
 * 2: Arguments <ANY> (default: [])
 * 3: Text <STRING> (default: "")
 * 4: Icon <STRING> (default "\a3\ui_f\data\igui\cfg\cursors\select_target_ca.paa")
 * 5: Icon Angle <NUMBER> (default: 45)
 * 6: Color <ARRAY> (default: [1, 0, 0, 1])
 * 7: Modifier Function <CODE> (default: {})
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, {systemChat str _this}, [], "Target"] call zen_common_fnc_selectPosition
 *
 * Public: No
 */

// Handle only one object passed, convert to array for loops
#define TO_ARRAY(x) (if (x isEqualType []) then {x} else {[x]})

params [
    ["_objects", [], [objNull, []]],
    ["_function", {}, [{}]],
    ["_args", []],
    ["_text", "", [""]],
    ["_icon", ICON_TARGET, [""]],
    ["_angle", 45, [0]],
    ["_color", [1, 0, 0, 1], [[]], 4],
    ["_modifierFunction", {}, [{}]]
];

// Exit with failure if an instance is already active
if (GVAR(selectPositionActive)) exitWith {
    [false, _objects, [0, 0, 0], _args, false, false, false] call _function;
};

GVAR(selectPositionActive) = true;

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
private _visuals = [_text, _icon, _angle, _color];

private _mouseEH = [_display, "MouseButtonDown", {
    params ["", "_button", "", "", "_shift", "_ctrl", "_alt"];

    if (_button != 0) exitWith {};

    private _position = [] call FUNC(getPosFromScreen);
    _thisArgs params ["_objects", "_function", "_args"];

    [true, _objects, _position, _args, _shift, _ctrl, _alt] call _function;

    GVAR(selectPositionActive) = false;
}, [_objects, _function, _args]] call CBA_fnc_addBISEventHandler;

private _keyboardEH = [_display, "KeyDown", {
    params ["", "_key", "_shift", "_ctrl", "_alt"];

    if (_key != DIK_ESCAPE) exitWith {false};

    private _position = [] call FUNC(getPosFromScreen);
    _thisArgs params ["_objects", "_function", "_args"];

    [false, _objects, _position, _args, _shift, _ctrl, _alt] call _function;

    GVAR(selectPositionActive) = false;

    true // handled
}, [_objects, _function, _args]] call CBA_fnc_addBISEventHandler;

private _drawEH = [_ctrlMap, "Draw", {
    params ["_ctrlMap"];
    _thisArgs params ["_objects", "_args", "_visuals", "_modifierFunction"];

    private _position = [] call FUNC(getPosFromScreen);
    [_objects, _position, _args, _visuals] call _modifierFunction;
    _visuals params ["_text", "_icon", "_angle", "_color"];

    if (isLocalized _text) then {
        _text = localize _text;
    };

    private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
    private _textSize = 0.05 max ctrlMapScale _ctrlMap min 0.07;

    _ctrlMap drawIcon [_icon, _color, _pos2D, 24, 24, _angle, _text, 0, _textSize, "RobotoCondensed", "right"];

    {
        _ctrlMap drawLine [_x, _pos2D, _color];
    } forEach TO_ARRAY(_objects);
}, [_objects, _args, _visuals, _modifierFunction]] call CBA_fnc_addBISEventHandler;

[{
    params ["_args", "_pfhID"];
    _args params ["_objects", "_function", "_args", "_visuals", "_modifierFunction", "_mouseEH", "_keyboardEH", "_drawEH"];

    // End selection with failure if an object is deleted, Zeus display is closed, or pause menu is opened
    if (
        TO_ARRAY(_objects) findIf {isNull _x} != -1
        || {isNull findDisplay IDD_RSCDISPLAYCURATOR}
        || {!isNull findDisplay IDD_INTERRUPT}
    ) then {
        [false, _objects, [0, 0, 0], _args, false, false, false] call _function;
        GVAR(selectPositionActive) = false;
    };

    // Exit if selection is no longer active, remove added event handlers
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

    private _position = [] call FUNC(getPosFromScreen);
    [_objects, _position, _args, _visuals] call _modifierFunction;
    _visuals params ["_text", "_icon", "_angle", "_color"];

    if (isLocalized _text) then {
        _text = localize _text;
    };

    _position = ASLtoAGL _position;

    drawIcon3D [_icon, _color, _position, 1.5, 1.5, _angle, _text];

    {
        drawLine3D [ASLtoAGL getPosASLVisual _x, _position, _color];
    } forEach TO_ARRAY(_objects);
}, 0, [_objects, _function, _args, _visuals, _modifierFunction, _mouseEH, _keyboardEH, _drawEH]] call CBA_fnc_addPerFrameHandler;
