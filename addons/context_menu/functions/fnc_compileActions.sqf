#include "script_component.hpp"
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

private _fnc_getActionData = {
    params ["_actionsConfig"];

    private _actions = [];

    {
        private _entryConfig = _x;

        private _actionName = configName _entryConfig;
        private _displayName = getText (_entryConfig >> "displayName");

        private _iconFile = getText (_entryConfig >> "icon");
        private _iconColor = getArray (_entryConfig >> "iconColor");

        if !(_iconColor isEqualTypeArray [1, 1, 1, 1]) then {
            _iconColor = [1, 1, 1, 1];
        };

        private _statement = compile getText (_entryConfig >> "statement");
        private _condition = compile getText (_entryConfig >> "condition");

        if (_condition isEqualTo {}) then {
            _condition = {true};
        };

        private _args = [_entryConfig, "args", []] call BIS_fnc_returnConfigEntry;

        private _insertChildren = compile getText (_entryConfig >> "insertChildren");
        private _modifierFunction = compile getText (_entryConfig >> "modifierFunction");

        private _children = [_entryConfig] call _fnc_getActionData;
        [_children, 2, false] call CBA_fnc_sortNestedArray;

        private _priority = getNumber (_entryConfig >> "priority");

        private _actionEntry = [
            [
                _actionName,
                _displayName,
                _iconFile,
                _iconColor,
                _statement,
                _condition,
                _args,
                _insertChildren,
                _modifierFunction
            ],
            _children,
            _priority
        ];

        _actions pushBack _actionEntry;
    } forEach configProperties [_actionsConfig, "isClass _x", true];

    _actions
};

private _contextActions = [configFile >> QGVAR(actions)] call _fnc_getActionData;

// Support for missionConfigFile actions, need special handling to support adding to paths that exist from configFile
private _missionActions = [missionConfigFile >> QGVAR(actions)] call _fnc_getActionData;

private _fnc_addMissionActions = {
    params ["_actionsArray", "_actionsToAdd"];

    {
        _x params ["_action", "_actionChildren"];
        _action params ["_actionName"];

        private _index = _actionsArray findIf {
            (_x select 0 select 0) isEqualTo _actionName;
        };

        if (_index == -1) then {
            _actionsArray pushBack _x;
        } else {
            private _children = _actionsArray select _index select 1;
            [_children, _actionChildren] call _fnc_addMissionActions;
        };
    } forEach _actionsToAdd;

    [_actionsArray, 2, false] call CBA_fnc_sortNestedArray;
};

[_contextActions, _missionActions] call _fnc_addMissionActions;

/*
[
    [
        [
            _actionName,
            _displayName,
            _iconFile,
            _iconColor,
            _statement,
            _condition,
            _args,
            _insertChildren,
            _modifierFunction
        ],
        [childrenActions],
        _priority
    ]
]
*/

missionNamespace setVariable [QGVAR(actions), _contextActions];
