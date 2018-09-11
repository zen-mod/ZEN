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

private _fnc_getActionData = {
    params ["_actionsConfig"];

    private _actions = [];

    {
        private _entryConfig = _x;

        private _actionName = configName _entryConfig;
        private _displayName = getText (_entryConfig >> "displayName");
        private _picture = getText (_entryConfig >> "picture");

        private _statement = compile getText (_entryConfig >> "statement");
        private _condition = compile getText (_entryConfig >> "condition");
        if (_condition isEqualTo {}) then {_condition = {true}};

        private _priority = getNumber (_entryConfig >> "priority");

        private _children = [_entryConfig] call _fnc_getActionData;
        [_children, 5, false] call CBA_fnc_sortNestedArray;

        private _actionEntry = [
            _actionName,
            _displayName,
            _picture,
            _statement,
            _condition,
            _priority,
            _children
        ];

        _actions pushBack _actionEntry;
    } forEach configProperties [_actionsConfig, "isClass _x", true];

    _actions
};

private _contextActions = [configFile >> QGVAR(actions)] call _fnc_getActionData;
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

// Passed parameters: [_positionASL, _selectedObjects, _selectedGroups, _selectedWaypoints, _selectedMarkers]
