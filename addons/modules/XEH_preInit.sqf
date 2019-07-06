#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorObjectPlaced",
    {
        if (param[1] isKindOf "Module_F") then {
            _this call FUNC(handleModulePlaced);
        };
    }];
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
