#include "script_component.hpp"

private _factions = [];
private _cfgVehicles = configFile >> "CfgVehicles";
private _cfgFactionClasses = configFile >> "CfgFactionClasses";
private _cfgEditorCategories = configFile >> "CfgEditorCategories";

// Zeus only includes objects defined in the units array of CfgPatches classes
{
    {
        // Classes that do not inherit from AllVehicles have thier side ignored and are considered props (Zeus also ignores animals)
        // The isEqualType check is here because some mods are incorrectly configured and have numbers in the CfgPatches units array
        if (_x isEqualType "" && {_x isKindOf "AllVehicles"} && {!(_x isKindOf "Animal")}) then {
            private _config = _cfgVehicles >> _x;

            // scopeCurator always has priority over scope, scope is only used if scopeCurator is not defined
            if (getNumber (_config >> "scopeCurator") == 2 || {getNumber (_config >> "scope") == 2 && {!isNumber (_config >> "scopeCurator")}}) then {
                private _side = getNumber (_config >> "side");

                if (_side in [0, 1, 2, 3]) then {
                    // Either editorCategory or faction can be used to set an object's category
                    // Usually, faction is used for characters and vehicles and editorCategory is used for props
                    // When both are present, editorCategory has priority and is used by Zeus
                    private _factionConfig = if (isText (_config >> "editorCategory")) then {
                        _cfgEditorCategories >> getText (_config >> "editorCategory")
                    } else {
                        _cfgFactionClasses >> getText (_config >> "faction")
                    };

                    _factions pushBackUnique [getText (_factionConfig >> "displayName"), configName _factionConfig, _side];
                };
            };
        };
    } forEach getArray (_x >> "units");
} forEach configProperties [configFile >> "CfgPatches", "isClass _x"];

// Group compositions do not necessarily use the same faction names as the object's they contain
{
    private _side = getNumber (_x >> "side");

    if (_side in [0, 1, 2, 3]) then {
        {
            private _name = getText (_x >> "name");

            // Add the faction if one with this name and side does not exist yet
            if (_factions findIf {_x select 0 == _name && {_x select 2 == _side}} == -1) then {
                private _faction = configName _x;

                // Add "_groups" suffix to the faction class name if it already exists
                // Happens when groups use the same faction class as objects but with a different display name
                if (_factions findIf {_x select 1 == _faction} != -1) then {
                    _faction = _faction + "_groups";
                };

                _factions pushBackUnique [_name, _faction, _side];
            };
        } forEach configProperties [_x, "isClass _x"];
    };
} forEach configProperties [configFile >> "CfgGroups", "isClass _x"];

// Sort factions in ascending order by name
_factions sort true;

uiNamespace setVariable [QGVAR(factions), _factions];
