#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

GVAR(canContext) = true;
GVAR(holdingRMB) = false;
GVAR(contextGroups) = [];
GVAR(mousePosition) = [0, 0];
GVAR(hovered) = [];
GVAR(selected) = [[], [], [], []];

ADDON = true;
