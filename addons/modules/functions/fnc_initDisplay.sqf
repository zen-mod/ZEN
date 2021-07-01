#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the given Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_initDisplay
 *
 * Public: No
 */

params ["_display"];

private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _displayName = getText (configOf _logic >> "displayName");
private _config = _display getVariable QEGVAR(common,config);

// Set the display's title to the module name
private _ctrlTitle = _display displayCtrl IDC_TITLE;
_ctrlTitle ctrlSetText toUpper _displayName;

// Adjust display element positions based on the content height
[_display] call EFUNC(common,initDisplayPositioning);

// Handle closing the display if the logic is destroyed
if (getNumber (_config >> "checkLogic") > 0) then {
    [{
        params ["_display", "_logic"];

        isNull _display || {!alive _logic}
    }, {
        params ["_display"];

        _display closeDisplay IDC_CANCEL;
    }, [_display, _logic]] call CBA_fnc_waitUntilAndExecute;
};

// Execute the display specific function
private _function = getText (_config >> "function");

if (isNil _function) then {
    _function = compile _function;
} else {
    _function = missionNamespace getVariable _function;
};

[_display, _logic] call _function;
