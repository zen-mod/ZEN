#include "script_component.hpp"

#include "XEH_PREP.hpp"

// Compile mine types
private _mineTypes = [];

{
    private _configName = configName _x;
    if (_configName isKindOf "ModuleMine_F" && {_configName != "ModuleMine_F"} && {_configName != "ModuleExplosive_F"}) then {
        _mineTypes pushBack [getText (_x >> "displayName"), _configName];
    };
} forEach ("true" configClasses (configFile >> "CfgVehicles"));

uiNamespace setVariable [QGVAR(mineTypes), _mineTypes];

call FUNC(compileAircraft);
