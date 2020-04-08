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
 * 4: Number of Rounds <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicles, "015734", 50, "8Rnd_82mm_Mo_shells", 4] call zen_modules_fnc_moduleFireMission
 *
 * Public: No
 */

params ["_vehicles", "_target", "_spread", "_magazine", "_rounds"];

private _eta = selectMin (_vehicles apply {
    [_x, _target, _magazine] call EFUNC(common,getArtilleryETA);
});

if (_eta == -1) exitWith {
    [LSTRING(NotInRangeOfArtillery)] call EFUNC(common,showMessage);
};

{
    [QEGVAR(common,fireArtillery), [_x, _target, _spread, _magazine, _rounds], _x] call CBA_fnc_targetEvent;
} forEach _vehicles;

[LSTRING(ModuleFireMission_ArtilleryETA), _eta toFixed 1] call EFUNC(common,showMessage);
