#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

[QGVAR(setHitPointsDamage), {
    params ["_vehicle", "_damageValues"];

    {
        _vehicle setHitIndex [_forEachIndex, _x, false];
    } forEach _damageValues;
}] call CBA_fnc_addEventHandler;

[
    "Object",
    "STR_A3_NormalDamage1",
    {
        [_entity] call FUNC(configure);
    },
    {
        alive _entity && {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}
    }
] call EFUNC(attributes,addButton);

ADDON = true;
