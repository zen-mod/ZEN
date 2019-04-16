#include "script_component.hpp"

if (isServer) then {
    [QGVAR(moduleAmbientAnimStart), FUNC(moduleAmbientAnimStart)] call CBA_fnc_addEventHandler; 
};

[QGVAR(sayMessage), BIS_fnc_sayMessage] call CBA_fnc_addEventHandler;
[QGVAR(carrierInit), BIS_fnc_Carrier01Init] call CBA_fnc_addEventHandler;
[QGVAR(destroyerInit), BIS_fnc_Destroyer01Init] call CBA_fnc_addEventHandler;
[QGVAR(moveToRespawnPosition), BIS_fnc_moveToRespawnPosition] call CBA_fnc_addEventHandler;
[QGVAR(taskPatrol), CBA_fnc_taskPatrol] call CBA_fnc_addEventHandler;

// Function needs to be spawned
[QGVAR(earthquake), {_this spawn BIS_fnc_earthquake}] call CBA_fnc_addEventHandler;
