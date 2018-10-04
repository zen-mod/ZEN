/*
 * Author: PabstMirror, mharis001
 * Allows Zeus to click to indicate position in 3D or on map.
 * Will not overwrite currently running getModuleTarget.
 *
 * Arguments:
 * 0: Source object <OBJECT>
 * 1: Code to run when position selected <CODE>
 *    - Code is passed:
 *    0: Successful <BOOL>
 *    1: Object <OBJECT>
 *    2: Position ASL <ARRAY>
 *    3: State of Shift <BOOL>
 *    4: State of Ctrl <BOOL>
 *    5: State of Alt <BOOL>
 * 2: Text <STRING> (default: "")
 * 3: Icon file <STRING> (default: "\a3\ui_f\data\IGUI\Cfg\Cursors\select_target_ca.paa")
 * 4: Icon color <ARRAY> (default: [1, 0, 0, 1])
 * 5: Icon angle <NUMBER> (default: 45)
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, {systemChat str _this}, "Test Target"] call zen_common_fnc_getModuleTarget
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_object", "_code", ["_text", ""], ["_icon", ICON_TARGET], ["_color", [1, 0, 0, 1]], ["_angle", 45]];

// Exit with failed if already running
if (GVAR(getModuleTargetRunning)) exitWith {
    [false, _object, [0, 0, 0], false, false, false] call _code;
    ERROR("getModuleTarget already running");
};

// Set running and store current params
GVAR(getModuleTargetRunning) = true;
GVAR(getModuleTargetParams) = [_object, _code, _text, _icon, _color, _angle];

private _display = findDisplay IDD_RSCDISPLAYCURATOR;

// Add mouse button EH to the Zeus display
GVAR(getModuleTargetMouseEH) = _display displayAddEventHandler ["MouseButtonDown", {
    params ["_display", "_button", "", "", "_shift", "_ctrl", "_alt"];

    // Only watch for LMB
    if (_button != 0) exitWith {};

    // Get mouse position
    private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    private _mousePosASL = if (ctrlShown _ctrlMap) then {
        private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
        _pos2D + [getTerrainHeightASL _pos2D];
    } else {
        AGLtoASL screenToWorld getMousePosition;
    };

    // Call code with success
    GVAR(getModuleTargetParams) params ["_object", "_code"];
    [true, _object, _mousePosASL, _shift, _ctrl, _alt] call _code;

    GVAR(getModuleTargetRunning) = false;
}];

// Add keyboard EH to the Zeus display
GVAR(getModuleTargetKeyboardEH) = _display displayAddEventHandler ["KeyDown", {
    params ["_display", "_key", "_shift", "_ctrl", "_alt"];

    // Only watch for ESC
    if (_key != DIK_ESCAPE) exitWith {};

    // Get mouse position
    private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    private _mousePosASL = if (ctrlShown _ctrlMap) then {
        private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
        _pos2D + [getTerrainHeightASL _pos2D];
    } else {
        AGLtoASL screenToWorld getMousePosition;
    };

    // Call code with failure
    GVAR(getModuleTargetParams) params ["_object", "_code"];
    [false, _object, _mousePosASL, _shift, _ctrl, _alt] call _code;

    GVAR(getModuleTargetRunning) = false;
    true
}];

// Add draw EH to the Zeus map (draws the 2D icon and line)
private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
GVAR(getModuleTargetDrawEH) = _ctrlMap ctrlAddEventHandler ["Draw", {
    params ["_ctrlMap"];

    GVAR(getModuleTargetParams) params ["_object", "", "_text", "_icon", "_color", "_angle"];

    private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
    private _textScale = ctrlMapScale _ctrlMap min 0.07 max 0.05;
    _ctrlMap drawIcon [_icon, _color, _pos2D, 24, 24, _angle, _text, 1, _textScale, "RobotoCondensed", "right"];
    _ctrlMap drawLine [_object, _pos2D, _color];
}];

// Add PFH to check for exit (also draws 3D icon and line)
[{
    params ["_args", "_pfhID"];
    _args params ["_object", "_code", "_text", "_icon", "_color", "_angle"];

    // Check for null object, Zeus display null, or interrupt display open
    if (isNull _object || {isNull findDisplay IDD_RSCDISPLAYCURATOR} || {!isNull findDisplay IDD_INTERRUPT}) then {
        TRACE_3("Null exit",isNull _object,isNull findDisplay IDD_RSCDISPLAYCURATOR,isNull findDisplay IDD_INTERRUPT);
        [false, _object, [0, 0, 0], false, false, false] call _code;
        GVAR(getModuleTargetRunning) = false;
    };

    // Exit if no longer running, remove EHs and PFH
    if (!GVAR(getModuleTargetRunning)) exitWith {
        TRACE_4("Cleaning up",_pfhID,GVAR(getModuleTargetMouseEH),GVAR(getModuleTargetKeyboardEH),GVAR(getModuleTargetDrawEH));
        private _display = findDisplay IDD_RSCDISPLAYCURATOR;
        _display displayRemoveEventHandler ["MouseButtonDown", GVAR(getModuleTargetMouseEH)];
        _display displayRemoveEventHandler ["KeyDown", GVAR(getModuleTargetKeyboardEH)];

        private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
        _ctrlMap ctrlRemoveEventHandler ["Draw", GVAR(getModuleTargetDrawEH)];

        GVAR(getModuleTargetParams) = nil;
        GVAR(getModuleTargetMouseEH) = nil;
        GVAR(getModuleTargetKeyboardEH) = nil;
        GVAR(getModuleTargetDrawEH) = nil;

        [_pfhID] call CBA_fnc_removePerFrameHandler;
    };

    // Draw 3D icon and line
    private _mousePosAGL = screenToWorld getMousePosition;
    drawIcon3D [_icon, _color, _mousePosAGL, 1.5, 1.5, _angle, _text];
    drawLine3D [_mousePosAGL, ASLtoAGL getPosASL _object, _color];
}, 0, [_object, _code, _text, _icon, _color, _angle]] call CBA_fnc_addPerFrameHandler;
