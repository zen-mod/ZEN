#include "script_component.hpp"
/*
 * Author: mharis001
 * Adds an attribute to the given attributes display type.
 *
 * Arguments:
 * 0: Display Type <STRING>
 * 1: Label and Tooltip <STRING|ARRAY>
 * 2: Control <STRING>
 * 3: Value Info <ANY> (default: [])
 * 4: Statement <CODE> (default: {})
 * 5: Default Value <CODE> (default: {})
 * 6: Condition <CODE> (default: {true})
 * 7: Priority <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_attributes_fnc_addAttribute
 *
 * Public: No
 */

params [
    ["_type", "", [""]],
    ["_name", "", ["", []]],
    ["_control", "", [""]],
    ["_valueInfo", []],
    ["_statement", {}, [{}]],
    ["_defaultValue", {}, [{}]],
    ["_condition", {true}, [{}]],
    ["_priority", 0, [0]]
];

_name params [
    ["_displayName", "", [""]],
    ["_tooltip", "", [""]]
];

if (isLocalized _displayName) then {
    _displayName = localize _displayName;
};

if (isLocalized _tooltip) then {
    _tooltip = localize _tooltip;
};

private _attributes = GVAR(attributes) getVariable _type;

if (isNil "_attributes") then {
    _attributes = [];
    GVAR(attributes) setVariable [_type, _attributes];
};

_attributes pushBack [_displayName, _tooltip, _control, _valueInfo, _statement, _defaultValue, _condition, _priority];

// Sort the attributes based on priority
[_attributes, 7, false] call CBA_fnc_sortNestedArray;
