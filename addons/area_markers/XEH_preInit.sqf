#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (isServer) then {
    // Unique ID for creating markers
    GVAR(nextID) = 0;
};

if (hasInterface) then {
    GVAR(colors) = createHashMap;

    {
        GVAR(colors) set [configName _x, (_x >> "color") call BIS_fnc_colorConfigToRGBA];
    } forEach configProperties [configFile >> "CfgMarkerColors", "isClass _x"];

    // List of editable area markers
    GVAR(markers) = [];

    // List of marker names that are blacklisted from being edited through Zeus
    // A marker is blacklisted if its name contains any of strings in this list
    GVAR(blacklist) = [];

    // Map of marker names and their corresponding icon controls
    GVAR(icons) = createHashMap;
};

ADDON = true;
