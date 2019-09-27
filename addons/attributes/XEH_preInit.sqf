#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Namespace to store data of all attributes displays
GVAR(displays) = [] call CBA_fnc_createNamespace;

// Namespace to track previously selected marker colors by marker type
// Color is applied to newly placed markers of the same type
GVAR(previousMarkerColors) = [] call CBA_fnc_createNamespace;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
    _logic addEventHandler ["CuratorMarkerPlaced", {call FUNC(handleMarkerPlaced)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

#include "initAttributes.sqf"

ADDON = true;
