#include "script_component.hpp"
/*
 * Author: mharis001
 * Compiles a list of all infantry, vehicles, and groups avaiable for reinforcements.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_modules_fnc_compileReinforcements
 *
 * Public: No
 */

private _fnc_addSorted = {
    params ["_baseArray", "_config"];

    private _side = getNumber (_config >> "side");
    private _faction = getText (_config >> "faction");

    if (_side in [0, 1, 2, 3] && {_faction != ""}) then {
        // Switch BLUFOR and OPFOR side IDs
        _side = [1, 0, 2, 3] select _side;

        private _sideHash = _baseArray param [_side];

        if (isNil "_sideHash") then {
            _sideHash = createHashMap;
            _baseArray set [_side, _sideHash];
        };

        private _factionHash = _sideHash get _faction;

        if (isNil "_factionHash") then {
            _factionHash = createHashMap;
            _sideHash set [_faction, _factionHash];
        };

        private _category = getText (_config >> "editorSubcategory");
        private _categoryList = _factionHash get _category;

        if (isNil "_categoryList") then {
            _categoryList = [];
            _factionHash set [_category, _categoryList];
        };

        _categoryList pushBack _className;
    };
};

private _vehicles = [];
private _infantry = [];

{
    if (getNumber (_x >> "scope") == 2) then {
        private _className = configName _x;

        if (getNumber (_x >> "isMan") == 1) exitWith {
            [_infantry, _x] call _fnc_addSorted;
        };

        if (
            (_className isKindOf "LandVehicle" || {_className isKindOf "Air"} || {_className isKindOf "Ship"})
            && {_x call EFUNC(common,getCargoPositionsCount) > 0}
        ) then {
            [_vehicles, _x] call _fnc_addSorted;
        };
    };
} forEach configProperties [configFile >> "CfgVehicles", "isClass _x"];

private _groups = [];

{
    private _side = getNumber (_x >> "side");

    if (_side in [0, 1, 2, 3]) then {
        // Switch BLUFOR and OPFOR side IDs
        _side = [1, 0, 2, 3] select _side;

        private _sideHash = _groups param [_side];

        if (isNil "_sideHash") then {
            _sideHash = createHashMap;
            _groups set [_side, _sideHash];
        };

        {
            private _faction = getText (_x >> "name");

            {
                private _category = getText (_x >> "name");

                {
                    private _units = configProperties [_x, "isClass _x"] apply {
                        getText (_x >> "vehicle");
                    };

                    // Add groups with only infantry units
                    if (_units findIf {!(_x isKindOf "CAManBase")} == -1) then {
                        private _name = getText (_x >> "name");
                        private _icon = getText (_x >> "icon");

                        private _factionHash = _sideHash get _faction;

                        if (isNil "_factionHash") then {
                            _factionHash = createHashMap;
                            _sideHash set [_faction, _factionHash];
                        };

                        private _categoryList = _factionHash get _category;

                        if (isNil "_categoryList") then {
                            _categoryList = [];
                            _factionHash set [_category, _categoryList];
                        };

                        _categoryList pushBack [_name, _icon, _units];
                    };
                } forEach configProperties [_x, "isClass _x"];
            } forEach configProperties [_x, "isClass _x"];
        } forEach configProperties [_x, "isClass _x"];
    };
} forEach configProperties [configFile >> "CfgGroups", "isClass _x"];

uiNamespace setVariable [QGVAR(reinforcementsCache), [_vehicles, _infantry, _groups]];
