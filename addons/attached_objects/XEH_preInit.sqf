#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initKeybinds.inc.sqf"

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectEdited", {call FUNC(handleObjectEdited)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
