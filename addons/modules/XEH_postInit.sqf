#include "script_component.hpp"

if (isServer) then {
    [QGVAR(moduleAmbientAnimStart), FUNC(moduleAmbientAnimStart)] call CBA_fnc_addEventHandler;
    [QGVAR(moduleAmbientFlyby), FUNC(moduleAmbientFlyby)] call CBA_fnc_addEventHandler;
    [QGVAR(moduleCAS), FUNC(moduleCAS)] call CBA_fnc_addEventHandler;
    [QGVAR(moduleEditableObjects), FUNC(moduleEditableObjects)] call CBA_fnc_addEventHandler;

    // Public variable to track created target logics
    missionNamespace setVariable [QGVAR(targetLogics), [], true];
};

[QGVAR(sayMessage), BIS_fnc_sayMessage] call CBA_fnc_addEventHandler;
[QGVAR(carrierInit), BIS_fnc_Carrier01Init] call CBA_fnc_addEventHandler;
[QGVAR(destroyerInit), BIS_fnc_Destroyer01Init] call CBA_fnc_addEventHandler;
[QGVAR(moveToRespawnPosition), BIS_fnc_moveToRespawnPosition] call CBA_fnc_addEventHandler;
[QGVAR(taskPatrol), CBA_fnc_taskPatrol] call CBA_fnc_addEventHandler;

[QGVAR(autoSeekBehavior), {
    params ["_unit"];
    _unit setUnitPos "UP";
    _unit setSpeedMode "FULL";
    _unit setBehaviour "CARELESS";
    _unit setCombatMode "BLUE";
    _unit disableAI "TARGET";
    _unit disableAI "AUTOTARGET";
    _unit allowFleeing 0;
}] call CBA_fnc_addEventHandler;

// Function needs to be spawned
[QGVAR(earthquake), {_this spawn BIS_fnc_earthquake}] call CBA_fnc_addEventHandler;
