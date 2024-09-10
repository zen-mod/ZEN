#include "script_component.hpp"

["zen_curatorDisplayLoaded", LINKFUNC(handleLoad)] call CBA_fnc_addEventHandler;
["zen_curatorDisplayUnloaded", LINKFUNC(handleUnload)] call CBA_fnc_addEventHandler;
[QGVAR(pingCurators), LINKFUNC(pingCurators)] call CBA_fnc_addEventHandler;
[QGVAR(treeButtonClicked), LINKFUNC(handleTreeButtons)] call CBA_fnc_addEventHandler;
