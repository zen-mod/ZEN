#include "script_component.hpp"
/*
 * Author: mharis001
 * Adds a button to the given attributes display type.
 *
 * Arguments:
 * 0: Display Type <STRING>
 * 1: Display Name and Tooltip <STRING|ARRAY>
 * 2: Statement <CODE>
 * 3: Condition <CODE> (default: {true})
 * 4: Close Display <BOOL> (default: false)
 *
 * Return Value:
 * Successfully Added <BOOL>
 *
 * Example:
 * ["Object", "Hint", {hint str _this}] call zen_attributes_fnc_addButton
 *
 * Public: No
 */

params [
    ["_displayType", "", [""]],
    ["_name", "", ["", []]],
    ["_statement", {}, [{}]],
    ["_condition", {true}, [{}]],
    ["_closeDisplay", false, [false]]
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

if (isLocalized _displayName) then {
    _displayName = localize _displayName;
};

if (isLocalized _tooltip) then {
    _tooltip = localize _tooltip;
};

_displayData select 3 pushBack [_displayName, _tooltip, _statement, _condition, _closeDisplay];

true
