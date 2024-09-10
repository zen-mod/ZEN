#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes modules created by Zeus. Simplified to only execute function where local.
 * Function is executed one frame later in an unscheduled environment.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_initModule
 *
 * Public: No
 */

params ["_logic"];

_logic hideObject true;

if (isServer) then {
    [{
        params ["_logic"];

        private _category = getText (configOf _logic >> "category");
        private _logicMain = missionNamespace getVariable ["bis_functions_mainscope", objNull];
        private _group = missionNamespace getVariable [format ["bis_fnc_initModules_%1", _category], group _logicMain];
        [_logic] joinSilent _group;
    }, _logic] call CBA_fnc_execNextFrame;
};

if (!local _logic) exitWith {};

private _function = getText (configOf _logic >> "function");
if (_function isEqualTo "") exitWith {};

if (isNil _function) then {
    _function = compile _function;
} else {
    _function = missionNamespace getVariable _function;
};

[_function, _logic] call CBA_fnc_execNextFrame;
