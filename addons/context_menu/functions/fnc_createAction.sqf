#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates an isolated context menu action.
 * Used to ensure that the action array is in the correct format.
 *
 * Arguments:
 * 0: Action Name <STRING>
 * 1: Display Name <STRING>
 * 2: Icon and Icon Color <STRING|ARRAY>
 * 3: Statement <CODE>
 * 4: Condition <CODE> (default: {true})
 * 5: Arguments <ANY> (default: [])
 * 6: Dynamic Children <CODE> (default: {})
 * 7: Modifier Function <CODE> (default: {})
 *
 * Return Value:
 * Action <ARRAY>
 *
 * Example:
 * ["HintTime", "Hint Time", "", {hint ([daytime] call BIS_fnc_timeToString)}] call zen_context_menu_fnc_createAction
 *
 * Public: Yes
 */

params [
    ["_actionName", "", [""]],
    ["_displayName", "", [""]],
    ["_iconArg", "", ["", []]],
    ["_statement", {}, [{}]],
    ["_condition", {true}, [{}]],
    ["_args", []],
    ["_insertChildren", {}, [{}]],
    ["_modifierFunction", {}, [{}]]
];

_iconArg params [
    ["_iconFile", "", [""]],
    ["_iconColor", [1, 1, 1, 1], [[]], 4]
];

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
]
