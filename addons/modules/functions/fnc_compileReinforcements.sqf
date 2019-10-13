#include "script_component.hpp"
/*
 * Author: mharis001
 * Compiles a list of all infantry and vehicles avaiable for reinforcements.
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
            _sideHash = [] call CBA_fnc_hashCreate;
            _baseArray set [_side, _sideHash];
        };

        private _factionHash = [_sideHash, _faction] call CBA_fnc_hashGet;

        if (isNil "_factionHash") then {
            _factionHash = [] call CBA_fnc_hashCreate;
            [_sideHash, _faction, _factionHash] call CBA_fnc_hashSet;
        };

        private _category = getText (_config >> "editorSubcategory");
        private _categoryList = [_factionHash, _category] call CBA_fnc_hashGet;

        if (isNil "_categoryList") then {
            _categoryList = [];
            [_factionHash, _category, _categoryList] call CBA_fnc_hashSet;
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

uiNamespace setVariable [QGVAR(reinforcementsCache), [_vehicles, _infantry]];
