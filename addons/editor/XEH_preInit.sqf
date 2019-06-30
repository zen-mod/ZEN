#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"
#include "initKeybinds.sqf"

GVAR(includeCrew) = true;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
    
    if (isServer) then {
        _logic setCuratorCameraAreaCeiling 1e5;
    };
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
