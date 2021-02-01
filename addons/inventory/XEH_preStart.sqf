#include "script_component.hpp"

#include "XEH_PREP.hpp"

// Disable CBA inventory attribute preload
uiNamespace setVariable ["cba_ui_curatorItemCache", []];

call FUNC(preload);
