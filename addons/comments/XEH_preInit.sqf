#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(icons) = createHashMap;
GVAR(draw3DAdded) = false;
GVAR(comments) = [];

#include "initSettings.inc.sqf"

ADDON = true;
