#include "script_component.hpp"

if (isServer) then {
    [QGVAR(setObjectStates), {
        params ["_object", "_states"];
        _states params ["_damage", "_simulation", "_hidden"];

        _object hideObjectGlobal _hidden;
        _object enableSimulationGlobal _simulation;
        [QEGVAR(common,allowDamage), [_object, _damage], _object] call CBA_fnc_targetEvent;
    }] call CBA_fnc_addEventHandler;
};

[QGVAR(setAbilities), {
    params ["_unit", "_abilities"];

    {
        _unit enableAIFeature [_x, _abilities select _forEachIndex];
    } forEach AI_ABILITIES;
}] call CBA_fnc_addEventHandler;
