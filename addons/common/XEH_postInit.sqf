#include "script_component.hpp"

[QGVAR(setUnitPos), {
    params ["_unit", "_mode"];
    _unit setUnitPos _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setBehaviour), {
    params ["_group", "_behaviour"];
    _group setBehaviour _behaviour;
}] call CBA_fnc_addEventHandler;

[QGVAR(setSpeedMode), {
    params ["_group", "_mode"];
    _group setSpeedMode _mode;
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    [QGVAR(hideObjectGlobal), {
        params ["_object", "_hide"];
        _object hideObjectGlobal _hide;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(enableSimulationGlobal), {
        params ["_object", "_enable"];
        _object enableSimulationGlobal _enable;
    }] call CBA_fnc_addEventHandler;
};
