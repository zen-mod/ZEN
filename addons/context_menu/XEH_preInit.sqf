#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"
#include "initKeybinds.sqf"

call FUNC(compileActions);

GVAR(hovered) = objNull;
GVAR(selected) = [];
GVAR(mousePos) = [0.5, 0.5];
GVAR(canContext) = true;
GVAR(holdingRMB) = false;
GVAR(contextGroups) = [];

["ZEN_displayCuratorLoad", LINKFUNC(initDisplayCurator)] call CBA_fnc_addEventHandler;

ADDON = true;
