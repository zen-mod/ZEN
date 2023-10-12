#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Compiling at preInit since profileNamespace colors are not available at preStart
call FUNC(compile);

// Sub-mode for custom marker trees (0: icons, 1: areas)
GVAR(mode) = 0;

ADDON = true;
