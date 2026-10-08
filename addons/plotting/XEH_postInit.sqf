#include "script_component.hpp"

if (hasInterface) then {
    ["zen_curatorDisplayLoaded", LINKFUNC(onLoad)] call CBA_fnc_addEventHandler;
    ["zen_curatorDisplayUnloaded", LINKFUNC(onUnload)] call CBA_fnc_addEventHandler;

    [QGVAR(plotAdded), LINKFUNC(addPlot)] call CBA_fnc_addEventHandler;
    [QGVAR(plotsCleared), LINKFUNC(clearPlots)] call CBA_fnc_addEventHandler;
};
