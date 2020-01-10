#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(appearances) = [] call CBA_fnc_createNamespace;

call FUNC(compileGrenades);

ADDON = true;
