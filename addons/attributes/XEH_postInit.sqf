#include "script_component.hpp"

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
