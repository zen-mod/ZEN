#include "script_component.hpp"
/*
 * Author: mharis001
 * Spawns the given composition around the center position.
 *
 * Arguments:
 * 0: Center Position <ARRAY>
 * 1: Composition Data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0], []] call zen_compositions_fnc_spawn
 *
 * Public: No
 */

params ["_centerPos", "_data"];

private _createdGroups   = [] call CBA_fnc_hashCreate;
private _fnc_createGroup = {
    params ["_side", "_index"];

    private _group = [_createdGroups, _index] call CBA_fnc_hashGet;

    if (isNil "_group") then {
        _group = createGroup [_side, true];
        [_createdGroups, _index, _group] call CBA_fnc_hashSet;
    };

    _group
};

private _fnc_createUnit = {
    params ["_unitData", ["_isCrew", false]];
    _unitData params ["_type", "_position", "_direction", "_loadout", "_group"];

    _group = _group call _fnc_createGroup;

    private _unit = _group createUnit [_type, [0, 0, 0], [], 0, "NONE"];
    _unit setUnitLoadout _loadout;

    if (!_isCrew) then {
        _unit setPosATL (_position vectorAdd _centerPos);
        _unit setDir _direction;
    };

    _unit
};

private _objects = [];

{
    _x params ["_type"];

    switch (true) do {
        case (_type isKindOf "CAManBase"): {
            _objects pushBack ([_x] call _fnc_createUnit);
        };
        case (_type isKindOf "AllVehicles"): {
            _x params ["", "_position", "_dirAndUp", "_customization", "_crew"];

            private _placement = ["NONE", "FLY"] select (_type isKindOf "Air" && {_position select 2 > 5});
            private _vehicle = createVehicle [_type, _position vectorAdd _centerPos, [], 0, _placement];
            _vehicle setVectorDirAndUp _dirAndUp;

            _customization params ["_textures", "_animations"];
            [_vehicle, _textures, _animations, true] call BIS_fnc_initVehicle;

            if (_vehicle in allUnitsUAV) then {
                createVehicleCrew _vehicle;
            } else {
                {
                    _x params ["_unitData", "_role", "_cargoIndex", "_turretPath"];

                    private _unit = [_unitData, true] call _fnc_createUnit;
                    _objects pushBack _unit;

                    switch (_role) do {
                        case "driver": {
                            _unit moveInDriver _vehicle;
                        };
                        case "commander": {
                            _unit moveInCommander _vehicle;
                        };
                        case "gunner": {
                            _unit moveInGunner _vehicle;
                        };
                        case "turret": {
                            _unit moveInTurret [_vehicle, _turretPath];
                        };
                        case "cargo": {
                            _unit moveInCargo [_vehicle, _cargoIndex];
                            _unit assignAsCargoIndex [_vehicle, _cargoIndex];
                        };
                    };
                } forEach _crew;
            };
        };
        default {
            _x params ["", "_position", "_dirAndUp"];

            private _object = createVehicle [_type, _position vectorAdd _centerPos, [], 0, "NONE"];
            _object setVectorDirAndUp _dirAndUp;

            _objects pushBack _object;
        };
    };
} forEach _data;

[QEGVAR(common,addObjects), [_objects]] call CBA_fnc_localEvent;
