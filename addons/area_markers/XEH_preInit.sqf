#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {
    GVAR(markers) = [];
    publicVariable QGVAR(markers);

    GVAR(nextID) = 0;
};

if (hasInterface) then {
    GVAR(colors) = [] call CBA_fnc_createNamespace;

    {
        if (getNumber (_x >> "scope") > 0) then {
            GVAR(colors) setVariable [configName _x, (_x >> "color") call BIS_fnc_colorConfigToRGBA];
        };
    } forEach configProperties [configFile >> "CfgMarkerColors", "isClass _x"];
};

ADDON = true;
