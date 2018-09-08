#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

GVAR(selected) = [];
GVAR(mousePos) = [0.5, 0.5];
GVAR(canContext) = true;
GVAR(holdingRMB) = false;
GVAR(contextGroups) = [];

ADDON = true;
