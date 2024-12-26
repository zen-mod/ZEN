#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.inc.sqf"

// For 3DEN comments in Zeus
if (is3DEN) then {
    // Arguments are for debugging
    add3DENEventHandler ["OnMissionSave", {["OnMissionSave"] call FUNC(save3DENComments)}];
    add3DENEventHandler ["OnMissionAutosave", {["OnMissionAutosave"] call FUNC(save3DENComments)}];
};

ADDON = true;
