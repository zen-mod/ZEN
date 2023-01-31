#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"
#include "initKeybinds.sqf"

GVAR(mousePos) = [0, 0];
GVAR(clipboard) = [];
GVAR(includeCrew) = true;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
    _logic addEventHandler ["CuratorObjectEdited", {call FUNC(handleObjectEdited)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
