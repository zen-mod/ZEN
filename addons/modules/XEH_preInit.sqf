#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Fix copy/pasted modules that use BI's module framework
["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectPlaced", {
        params ["", "_object"];

        if (_object isKindOf "Module_F" && {!(_object isKindOf QGVAR(moduleBase))}) then {
            _object setVariable ["BIS_fnc_initModules_activate", true, true];
        };
    }];
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
