#include "script_component.hpp"

#include "XEH_PREP.hpp"

// Get faction names for west, east, independent, and civilian sides
private _cfgFactionClasses = configFile >> "CfgFactionClasses";
private _factionNames = configProperties [_cfgFactionClasses, "isClass _x"] select {
    getNumber (_x >> "side") in [0, 1, 2, 3]
} apply {
    getText (_x >> "displayName")
};

// Find objects that are forced empty. This relatively small number of objects are included only in
// the empty tree and, if we delete the entire faction node, then there is no way to place them.
private _forcedEmptyFactions = [];
private _forcedEmptyObjects = createHashMap;

{
    if (
        getNumber (_x >> "scope") != 2
        || {getNumber (_x >> "editorForceEmpty") != 1}
    ) then {continue};

    private _faction = getText (_cfgFactionClasses >> getText (_x >> "faction") >> "displayName");
    _forcedEmptyFactions pushBack _faction;
    _forcedEmptyObjects set [configName _x, nil];
} forEach configProperties [configFile >> "CfgVehicles", "isClass _x"];

private _fastDeclutterFactions = (_factionNames - _forcedEmptyFactions) createHashMapFromArray [];
private _slowDeclutterFactions = _forcedEmptyFactions createHashMapFromArray [];
uiNamespace setVariable [QGVAR(fastDeclutterFactions), compileFinal _fastDeclutterFactions];
uiNamespace setVariable [QGVAR(slowDeclutterFactions), compileFinal _slowDeclutterFactions];
uiNamespace setVariable [QGVAR(forcedEmptyObjects), compileFinal _forcedEmptyObjects]
