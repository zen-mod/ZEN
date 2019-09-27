#include "script_component.hpp"
/*
 * Author: mharis001
 * Adds an attribute to the given attributes display type.
 *
 * Arguments:
 * 0: Display Type <STRING>
 * 1: Label and Tooltip <STRING|ARRAY>
 * 2: Control Type <STRING>
 * 3: Value Info <ANY> (default: [])
 * 4: Statement <CODE> (default: {})
 * 5: Default Value <CODE> (default: {})
 * 6: Condition <CODE> (default: {true})
 * 7: Priority <NUMBER> (default: 0)
 *
 * Return Value:
 * Successfully Added <BOOL>
 *
 * Example:
 * [] call zen_attributes_fnc_addAttribute
 *
 * Public: No
 */

params [
    ["_displayType", "", [""]],
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

private _displayData = GVAR(displays) getVariable _displayType;

if (isNil "_displayData") exitWith {
    WARNING_1("Display type (%1) has not been registered.",_displayType);
    false
};

private _attributes = _displayData select 2;

if (isLocalized _displayName) then {
    _displayName = localize _displayName;
};

if (isLocalized _tooltip) then {
    _tooltip = localize _tooltip;
};

_attributes pushBack [_displayName, _tooltip, _control, _valueInfo, _statement, _defaultValue, _condition, _priority];

// Sort the attributes based on priority
[_attributes, 7, false] call CBA_fnc_sortNestedArray;

true
