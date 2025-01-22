#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.inc.sqf"
#include "initKeybinds.inc.sqf"
#include "initKeybindsAIControl.inc.sqf"

GVAR(clipboard) = [];
GVAR(includeCrew) = true;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
    _logic addEventHandler ["CuratorPinged", {call FUNC(handleCuratorPinged)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
