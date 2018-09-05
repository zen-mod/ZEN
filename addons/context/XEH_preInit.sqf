#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

GVAR(canContext) = true;
GVAR(rightClick) = false;
GVAR(contextGroups) = [];
GVAR(hovered) = [];
GVAR(selected) = [[], [], [], []];

ADDON = true;
