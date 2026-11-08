#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {
    // Unique ID for creating comments
    GVAR(nextID) = 0;
};

// Map of comment IDs to data (3DEN comments are loaded in postInit)
GVAR(comments) = createHashMap;

// Map of comment IDs to icon controls
GVAR(icons) = createHashMap;

// IDs of the hovered comment and the comment being dragged, empty when there is none
GVAR(hoveredComment) = "";
GVAR(draggedComment) = "";

#include "initSettings.inc.sqf"

ADDON = true;
