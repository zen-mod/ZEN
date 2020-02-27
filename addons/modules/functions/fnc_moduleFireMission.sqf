#include "script_component.hpp"
/*
 * Author: mharis001, Kex
 * Zeus module function to perform an artillery fire mission.
 *
 * Arguments:
 * 0: Artillery Vehicles <ARRAY>
 * 1: Target Grid or Logic <STRING|OBJECT>
 * 2: Spread <NUMBER>
 * 3: Ammo Magazine <STRING>
 * 4: Rounds To Fire <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicles, "015734", 50, "8Rnd_82mm_Mo_shells", 4] call zen_modules_fnc_moduleFireMission
 *
 * Public: No
 */

params ["_vehicles", "_target", "_spread", "_ammo", "_rounds"];

private _position = if (_target isEqualType "") then {
    [_target, true] call CBA_fnc_mapGridToPos
} else {
    ASLtoAGL getPosASL _target
};

private _eta = selectMin (_vehicles apply {[_x, _position, _ammo] call EFUNC(common,getArtilleryETA)});

if (_eta == -1) exitWith {
    [LSTRING(NotInRangeOfArtillery)] call EFUNC(common,showMessage);
};

{
    [QGVAR(fireArtillery), [_x, _position, _spread, _ammo, _rounds], _x] call CBA_fnc_targetEvent;
} forEach _vehicles;

[LSTRING(ModuleFireMission_ArtilleryETA), _eta toFixed 1] call EFUNC(common,showMessage);
