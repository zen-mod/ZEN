#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.inc.sqf"

if (isServer) then {
    ["ModuleCurator_F", "Init", {
        params ["_logic"];

        _logic setCuratorCameraAreaCeiling 1e5;
    }, true, [], true] call CBA_fnc_addClassEventHandler;
};

ADDON = true;
