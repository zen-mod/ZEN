#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initKeybinds.inc.sqf"

GVAR(state) = false;
GVAR(light) = objNull;

ADDON = true;
