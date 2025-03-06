#include "script_component.hpp"

if (hasInterface) then {
    // All plots ordered by creation time, last is newest
    GVAR(plots) = [];

    ["zen_curatorDisplayLoaded", LINKFUNC(onLoad)] call CBA_fnc_addEventHandler;
    ["zen_curatorDisplayUnloaded", LINKFUNC(onUnload)] call CBA_fnc_addEventHandler;

    [QGVAR(plotAdded), LINKFUNC(addPlot)] call CBA_fnc_addEventHandler;
    [QGVAR(plotsCleared), LINKFUNC(clearPlots)] call CBA_fnc_addEventHandler;
};
