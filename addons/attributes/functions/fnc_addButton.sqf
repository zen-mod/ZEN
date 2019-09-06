#include "script_component.hpp"

params [
    ["_type", "", [""]],
    ["_name", "", ["", []]],
    ["_statement", {}, [{}]],
    ["_condition", {true}, [{}]],
    ["_closeDisplay", false, [false]]
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

private _buttons = GVAR(buttons) getVariable _type;

if (isNil "_buttons") then {
    _buttons = [];
    GVAR(buttons) setVariable [_type, _buttons];
};

_buttons pushBack [_displayName, _tooltip, _statement, _condition, _closeDisplay];
