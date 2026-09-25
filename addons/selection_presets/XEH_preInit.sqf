#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.inc.sqf"

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectSelectionChanged", {call FUNC(handleObjectSelectionChanged)}];
    _logic addEventHandler ["CuratorSelectionPresetSaved", {call FUNC(handlePresetSaved)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

{
    ["CAManBase", _x, LINKFUNC(handleUnitVehicleChanged), true, [], true] call CBA_fnc_addClassEventHandler;
} forEach ["GetInMan", "GetOutMan"];

// Registering the event in preInit ensures that all groups are handled
// postInit misses groups already part of the mission (i.e., from 3DEN)
addMissionEventHandler ["GroupCreated", {call FUNC(handleGroupCreated)}];

ADDON = true;
