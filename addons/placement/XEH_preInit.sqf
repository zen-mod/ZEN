#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.inc.sqf"

GVAR(helper) = objNull;
GVAR(object) = objNull;
GVAR(updatePFH) = -1;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
