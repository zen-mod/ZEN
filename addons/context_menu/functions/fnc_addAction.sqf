#include "script_component.hpp"
/*
 * Author: mharis001
 * Adds an action to the Zeus context menu.
 *
 * Arguments:
 * 0: Parent Path <ARRAY>
 * 1: Action Name <STRING>
 * 2: Display Name <STRING>
 * 3: Icon and Icon Color <STRING|ARRAY>
 * 4: Statement <CODE>
 * 5: Condition <CODE> (default: {true})
 * 6: Priority <NUMBER> (default: 0)
 *
 * Return Value:
 * Full Action Path <ARRAY>
 *
 * Example:
 * [[], "HintTime", "Hint Time", "", {hint ([daytime] call BIS_fnc_timeToString)}] call zen_context_menu_fnc_addAction
 *
 * Public: Yes
 */

if (canSuspend) exitWith {
    [FUNC(addAction), _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith {
    []
};

params [
    ["_parentPath", [], []],
    ["_actionName", "", [""]],
    ["_displayName", "", [""]],
    ["_iconArg", "", ["", []]],
    ["_statement", {}, [{}]],
    ["_condition", {true}, [{}]],
    ["_priority", 0, [0]]
];

_iconArg params [
    ["_iconFile", "", [""]],
    ["_iconColor", [1, 1, 1, 1], [[]], 4]
];

scopeName "Main";

private _parentNode = if (_parentPath isEqualTo []) then {
    GVAR(actions)
} else {
    private _fnc_findNode = {
        params ["_actions", "_level"];

        private _index = _actions findIf {
            (_x select 0) isEqualTo (_parentPath select _level);
        };

        if (_index == -1) then {
            ERROR_2("Failed to add action (%1) to parent path %2",_actionName,_parentPath);
            [] breakOut "Main";
        } else {
            private _children = _actions select _index select 7;

            if (count _parentPath == _level + 1) then {
                _children
            } else {
                [_children, _level + 1] call _fnc_findNode
            };
        };
    };

    [GVAR(actions), 0] call _fnc_findNode;
};

_parentNode pushBack [_actionName, _displayName, _iconFile, _iconColor, _statement, _condition, _priority, []];
[_parentNode, 6, false] call CBA_fnc_sortNestedArray;

_parentPath + [_actionName]
