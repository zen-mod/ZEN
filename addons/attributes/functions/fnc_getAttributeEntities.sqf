/*
 * Author: mharis001
 * Returns entities that are selected by Zeus based on passed entity.
 * Used by Zeus attribute displays to apply changes to all selected entities.
 *
 * Arguments:
 * 0: Entity <OBJECT|GROUP>
 *
 * Return Value:
 * Entities <ARRAY>
 *
 * Example:
 * [_entity] call zen_attributes_fnc_getAttributeEntities
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_entity"];
TRACE_1("Params",_entity);

switch (true) do {
    case (_entity isEqualType objNull): {
        if (_entity isKindOf "CAManBase") then {
            private _units = [];
            {
                if (_x isKindOf "CAManBase") then {
                    _units pushBack _x;
                } else {
                    if (_x isKindOf "LandVehicle" || {_x isKindOf "Air"} || {_x isKindOf "Ship"}) then {
                        _units append crew _x;
                    };
                };
            } forEach (curatorSelected select 0);
            _units arrayIntersect _units
        } else {
            private _canBeEmpty = isNull group _entity;
            (curatorSelected select 0) select {
                (_x isKindOf "LandVehicle" || {_x isKindOf "Air"} || {_x isKindOf "Ship"})
                && {_canBeEmpty || {!isNull group _x}}
            };
        };
    };
    case (_entity isEqualType grpNull): {
        private _units = [];
        {
            _units append units _x;
        } forEach (curatorSelected select 1);
        _units
    };
    default {[]};
};
