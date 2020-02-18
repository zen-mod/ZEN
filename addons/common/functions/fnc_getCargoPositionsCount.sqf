#include "script_component.hpp"
/*
 * Author: mharis001, NeilZar
 * Returns the number of cargo positions in the given vehicle.
 *
 * Arguments:
 * 0: Vehicle <STRING|OBJECT|CONFIG>
 *
 * Return Value:
 * Cargo Positions Count <NUMBER>
 *
 * Example:
 * ["B_MRAP_01_F"] call zen_common_fnc_getCargoPositionsCount
 *
 * Public: No
 */

params [["_config", "", ["", objNull, configNull]]];

if (_config isEqualType objNull) exitWith {
    count fullCrew [_config, "cargo", true] + count (allTurrets [_config, true] - allTurrets [_config, false])
};

if (_config isEqualType "") then {
    _config = configFile >> "CfgVehicles" >> _config;
};

private _turretCountFFV = 0;

private _fnc_turretsFFV = {
    params ["_config"];

    {
        if (getNumber (_x >> "showAsCargo") > 0) then {
            _turretCountFFV = _turretCountFFV + 1;
        };

        if (isClass (_x >> "Turrets")) then {
            _x call _fnc_turretsFFV;
        };
    } forEach ("true" configClasses (_config >> "Turrets"));
};

_config call _fnc_turretsFFV;

getNumber (_config >> "transportSoldier") + _turretCountFFV
