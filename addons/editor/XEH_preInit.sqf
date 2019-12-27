#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"
#include "initKeybinds.sqf"

GVAR(clipboard) = [];
GVAR(includeCrew) = true;

if (isServer) then {
    [QGVAR(deepPaste), LINKFUNC(deepPaste)] call CBA_fnc_addEventHandler;
};

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectPlaced", {call FUNC(handleObjectPlaced)}];
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
