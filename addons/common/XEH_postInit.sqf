#include "script_component.hpp"

[QGVAR(setUnitPos), {
    params ["_unit", "_mode"];
    _unit setUnitPos _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setBehaviour), {
    params ["_group", "_behaviour"];
    _group setBehaviour _behaviour;
}] call CBA_fnc_addEventHandler;
