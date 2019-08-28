#include "script_component.hpp"
/*
 * Author: mharis001
 * Serializes the given objects array into a composition data array.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 *
 * Return Value:
 * Composition Data <ARRAY>
 *
 * Example:
 * [allUnits] call zen_compositions_fnc_serialize
 *
 * Public: No
 */

params ["_objects"];

if (_objects isEqualTo []) exitWith {[]};

private _indexedGroups = [];

private _fnc_getGroupData = {
    params ["_unit"];

    private _group = group _unit;
    private _index = _indexedGroups find _group;

    if (_index == -1) then {
        _index = _indexedGroups pushBack _group;
    };

    [side _group, _index]
};

private _fnc_getUnitData = {
    params ["_unit"];

    [typeOf _unit, getPosATL _unit, getDir _unit, getUnitLoadout _unit, _unit call _fnc_getGroupData]
};

private _data = [];

{
    if (alive _x) then {
        switch (true) do {
            case (_x isKindOf "CAManBase"): {
                // Exit if the unit is in a vehicle and the vehicle is in the objects array
                // The unit will be included as part of the crew array of the vehicle
                if (vehicle _x != _x && {vehicle _x in _objects}) exitWith {};

                _data pushBack (_x call _fnc_getUnitData);
            };
            case (_x isKindOf "AllVehicles"): {
                private _customization = [_x] call BIS_fnc_getVehicleCustomization;

                private _crew = fullCrew [_x, "", false] apply {
                    _x params ["_unit", "_role", "_cargoIndex", "_turretPath"];
                    [_unit call _fnc_getUnitData, toLower _role, _cargoIndex, _turretPath]
                };

                _data pushBack [typeOf _x, getPosATL _x, [vectorDir _x, vectorUp _x], _customization, _crew];
            };
            default {
                _data pushBack [typeOf _x, getPosATL _x, [vectorDir _x, vectorUp _x]];
            };
        };
    };
} forEach _objects;

// Find the center position of the objects
private _sumX = 0;
private _sumY = 0;

{
    (_x select 1) params ["_posX", "_posY"];

    _sumX = _sumX + _posX;
    _sumY = _sumY + _posY;
} forEach _data;

private _centerPos = [_sumX / count _data, _sumY / count _data, 0];

// Adjust the objects to be based around the center
{
    _x set [1, _x select 1 vectorDiff _centerPos];
} forEach _data;

_data
