#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initKeybinds.sqf"

// Namespace thats stores data of all attribute displays
GVAR(displays) = [] call CBA_fnc_createNamespace;

// Namespace that tracks selected marker colors by marker type
// Colors are applied to newly placed markers of the same type
GVAR(previousMarkerColors) = [] call CBA_fnc_createNamespace;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorMarkerPlaced", {call FUNC(handleMarkerPlaced)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

// Initialize the core/default attributes
#include "initAttributes.sqf"

ADDON = true;
