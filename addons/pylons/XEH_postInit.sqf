#include "script_component.hpp"

[QGVAR(setLoadout), {
    params ["_aircraft", "_pylonLoadout"];

    {
        _x params ["_magazine", "_turretPath"];

        _aircraft setPylonLoadout [_forEachIndex + 1, _magazine, false, _turretPath];
    } forEach _pylonLoadout;
}] call CBA_fnc_addEventHandler;

[QGVAR(removeWeapons), {
    params ["_aircraft", "_turretPath", "_weapons"];

    {
        _aircraft removeWeaponTurret [_x, _turretPath];
    } forEach _weapons;
}] call CBA_fnc_addEventHandler;
