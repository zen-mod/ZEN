#include "script_component.hpp"
/*
 * Author: mharis001
 * Adds the given action to the ZEN context menu.
 *
 * Arguments:
 * 0: Action <ARRAY>
 * 1: Parent Path <ARRAY> (default: [])
 * 2: Priority <NUMBER> (default: 0)
 *
 * Return Value:
 * Full Action Path <ARRAY>
 *
 * Example:
 * [_action, [], 0] call zen_context_menu_fnc_addAction
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
    ["_action", [], [[]], 9],
    ["_parentPath", [], []],
    ["_priority", 0, [0]]
];

_action params ["_actionName"];

scopeName "Main";

private _parentNode = if (_parentPath isEqualTo []) then {
    GVAR(actions)
} else {
    private _fnc_findNode = {
        params ["_actions", "_level"];

        private _index = _actions findIf {
            (_x select 0 select 0) isEqualTo (_parentPath select _level);
        };

        if (_index == -1) then {
            ERROR_2("Failed to add action (%1) to parent path %2.",_actionName,_parentPath);
            [] breakOut "Main";
        } else {
            private _children = _actions select _index select 1;

            if (count _parentPath == _level + 1) then {
                _children
            } else {
                [_children, _level + 1] call _fnc_findNode
            };
        };
    };

    [GVAR(actions), 0] call _fnc_findNode;
};

_parentNode pushBack [_action, [], _priority];
[_parentNode, 2, false] call CBA_fnc_sortNestedArray;

_parentPath + [_actionName]
