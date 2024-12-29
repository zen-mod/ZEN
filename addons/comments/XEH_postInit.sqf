#include "script_component.hpp"

if (!hasInterface || is3DEN) exitWith {};

["zen_curatorDisplayLoaded", LINKFUNC(addDrawEventHandler)] call CBA_fnc_addEventHandler;

GVAR(3DENComments) = getMissionConfigValue [QGVAR(3DENComments), []];
TRACE_1("Loaded 3DEN Comments from mission",GVAR(3DENComments));
