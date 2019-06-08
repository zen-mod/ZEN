#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Disable CBA inventory attribute preload
uiNamespace setVariable ["cba_ui_curatorItemCache", []];

ADDON = true;
