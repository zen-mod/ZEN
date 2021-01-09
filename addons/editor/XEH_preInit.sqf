#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"
#include "initKeybinds.sqf"

GVAR(lastSelection) = [];
GVAR(savedSelection) = [];
GVAR(colour) = ["IGUI", "TEXT_RGB"] call BIS_fnc_displayColorGet;
GVAR(clipboard) = [];
GVAR(includeCrew) = true;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
    _logic addEventHandler ["CuratorGroupSelectionChanged", {call FUNC(handleSelectionChanged)}];
    _logic addEventHandler ["CuratorMarkerSelectionChanged", {call FUNC(handleSelectionChanged)}];
    _logic addEventHandler ["CuratorObjectSelectionChanged", {call FUNC(handleSelectionChanged)}];
    _logic addEventHandler ["CuratorWaypointSelectionChanged", {call FUNC(handleSelectionChanged)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
