#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the currently active actions from the given actions.
 *
 * Arguments:
 * 0: Actions <ARRAY>
 *
 * Return Value:
 * Active Actions <ARRAY>
 *
 * Example:
 * [_actions] call zen_context_menu_fnc_getActiveActions
 *
 * Public: No
 */

params ["_actions"];

SETUP_ACTION_VARS;

private _activeActions = [];

{
    _x params ["_action", "_children", "_priority"];
    _action params ["", "", "", "", "_statement", "_condition", "_args", "_insertChildren", "_modifierFunction"];

    // Check if the action should modified first
    if (_modifierFunction isNotEqualTo {}) then {
        _action = +_action; // Make a copy of the action for the function to modify
        [_action, ACTION_PARAMS] call _modifierFunction;
    };

    // Check if the action itself is active
    if (ACTION_PARAMS call _condition) then {
        // Get active children actions
        private _activeChildren = [_children] call FUNC(getActiveActions);

        // Check if the action has code to insert children dynamically
        if (_insertChildren isNotEqualTo {}) then {
            private _dynamicChildren = ACTION_PARAMS call _insertChildren;
            [_dynamicChildren, 2, false] call CBA_fnc_sortNestedArray;

            _activeChildren append ([_dynamicChildren] call FUNC(getActiveActions));
        };

        // Only add the action to active actions if its statement is not empty or it has active children
        if (_statement isNotEqualTo {} || {_activeChildren isNotEqualTo []}) then {
            _activeActions pushBack [_action, _activeChildren, _priority];
        };
    };
} forEach _actions;

_activeActions
