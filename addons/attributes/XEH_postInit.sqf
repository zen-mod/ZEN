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

[QGVAR(setSkills), {
    params ["_unit", "_skills"];

    {
        _unit setSkill [_x, _skills select _forEachIndex];
    } forEach [
        "aimingAccuracy",
        "aimingSpeed",
        "aimingShake",
        "commanding",
        "courage",
        "spotDistance",
        "spotTime",
        "reloadSpeed"
    ];
}] call CBA_fnc_addEventHandler;

[QGVAR(setAllHitPointsDamage), {
    params ["_vehicle", "_damageValues"];

    {
        _vehicle setHitIndex [_forEachIndex, _x, false];
    } forEach _damageValues;
}] call CBA_fnc_addEventHandler;
