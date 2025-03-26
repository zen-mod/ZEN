#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (hasInterface) then {
    GVAR(activePlot) = [];
    GVAR(draw3DAdded) = false;

    GVAR(plotTypes) = createHashMapFromArray [
        ["LINE", LINKFUNC(drawLine)],
        ["RADIUS", LINKFUNC(drawRadius)],
        ["RECTANGLE", LINKFUNC(drawRectangle)]
    ];

    GVAR(currentDistanceFormatter) = 0;
    GVAR(currentSpeedFormatter) = 0;
    GVAR(currentSpeedIndex) = 0;
    GVAR(currentAzimuthFormatter) = 0;
};

call FUNC(compileFormatters);

#include "initSettings.inc.sqf"
#include "initKeybinds.inc.sqf"

ADDON = true;
