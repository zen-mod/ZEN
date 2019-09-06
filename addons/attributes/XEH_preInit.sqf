#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(attributes) = [] call CBA_fnc_createNamespace;
GVAR(buttons)    = [] call CBA_fnc_createNamespace;

GVAR(markerColors) = [] call CBA_fnc_createNamespace;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorMarkerPlaced", {call FUNC(handleMarkerPlaced)}];
    _logic addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

#include "initAttributes.sqf"
#include "initButtons.sqf"

ADDON = true;
