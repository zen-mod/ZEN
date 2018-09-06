/*
 * Author: mharis001
 * Compiles context menu actions from config.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_context_menu_fnc_compileActions
 *
 * Public: No
 */
#include "script_component.hpp"

private _actionFnc = {
    params ["_config"];

    private _actionName = configName _config;
    private _displayName = getText (_config >> "displayName");
    private _picture = getText (_config >> "picture");

    private _statement = compile getText (_config >> "statement");

    private _condition = compile getText (_config >> "condition");
    if (_condition isEqualTo {}) then {_condition = {true}};

    private _priority = getNumber (_config >> "priority");

    [
        _actionName,
        _displayName,
        _picture,
        _statement,
        _condition,
        _priority
    ]
};

private _contextActions = [];

{
    private _action = _x call _actionFnc;

    private _children = [];
    {
        _children pushBack (_x call _actionFnc);
    } forEach configProperties [_x, QUOTE(isClass _x), true];
    [_children, 5, false] call CBA_fnc_sortNestedArray;
    _action pushBack _children;

    _contextActions pushBack _action;
} forEach configProperties [configFile >> QGVAR(actions), QUOTE(isClass _x), true];

[_contextActions, 5, false] call CBA_fnc_sortNestedArray;

missionNamespace setVariable [QGVAR(actions), _contextActions];

/*
[
    [
        _actionName,
        _displayName,
        _picture,
        _statement,
        _condition,
        _priority,
        [childrenActions]
    ]
]
*/
