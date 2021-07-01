#include "script_component.hpp"

ADDON = false;

// Create trees do not provide the faction class name that a given node represents
// Only the faction's name and side can be obtained from the tree
// This namespace maps a faction's name and side to its corresponding setting variable name
GVAR(map) = createHashMap;

{
    _x params ["_name", "_faction", "_side"];

    private _varName = format [QGVAR(%1_%2), _side, _faction];
    GVAR(map) set [[_side, _name], _varName];

    private _sideName = ["str_east", "str_west", "str_guerrila", "str_civilian"] select _side;
    [_varName, "CHECKBOX", _name, [LSTRING(DisplayName), _sideName], true, false] call CBA_fnc_addSetting;
} forEach (uiNamespace getVariable QGVAR(factions));

ADDON = true;
