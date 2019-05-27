#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(markerColors) = [] call CBA_fnc_createNamespace;

["ModuleCurator_F", "Init", {
    params ["_logic"];

    _logic addEventHandler ["CuratorMarkerPlaced", {
        params ["", "_marker"];

        private _color = GVAR(markerColors) getVariable [markerType _marker, "Default"];
        _marker setMarkerColor _color;
    }];
}, true, [], true] call CBA_fnc_addClassEventHandler;

ADDON = true;
