#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {
    // Unique ID for creating comments
    GVAR(nextID) = 0;
};

if (hasInterface) then {
    // Map of all comments
    // Keys are comment IDs and values are the data
    GVAR(comments) = createHashMap;
    GVAR(icons) = createHashMap;

    GVAR(draw3DAdded) = false;

    GVAR(movingComment) = [];
};

#include "initSettings.inc.sqf"

ADDON = true;
