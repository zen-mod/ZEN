#include "script_component.hpp"

[QGVAR(sayMessage), BIS_fnc_sayMessage] call CBA_fnc_addEventHandler;
[QGVAR(moveToRespawnPosition), BIS_fnc_moveToRespawnPosition] call CBA_fnc_addEventHandler;
[QGVAR(taskPatrol), CBA_fnc_taskPatrol] call CBA_fnc_addEventHandler;
