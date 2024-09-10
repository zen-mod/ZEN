#include "script_component.hpp"
/*
 * Author: NeilZar
 * Returns the (gunner) name of the given vehicle's specified turret.
 *
 * Arguments:
 * 0: Vehicle <STRING|OBJECT|CONFIG>
 * 1: Turret Path <ARRAY>
 *
 * Return Value:
 * Gunner Name <STRING>
 *
 * Example:
 * ["B_MRAP_01_hmg_F", [0]] call zen_common_fnc_getGunnerName
 *
 * Public: No
 */

params [["_vehicle", "", ["", objNull, configNull]], ["_turretPath", [], [[]]]];

private _name = getText ([_vehicle, _turretPath] call CBA_fnc_getTurret >> "gunnerName");

if (_name == "") then {
    _name = localize (["str_driver", "str_pilot"] select (_vehicle isKindOf "Air"));
};

_name
