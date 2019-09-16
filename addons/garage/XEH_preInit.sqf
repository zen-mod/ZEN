#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(helperPos) = [0, 0, -1];
GVAR(camDistance) = 100;
GVAR(camPitch) = 15;
GVAR(camYaw) = -45;

ADDON = true;
