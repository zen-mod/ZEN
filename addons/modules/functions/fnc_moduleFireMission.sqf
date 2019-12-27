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
 * [[artillery1, artillery2], "015734", 50, "ArtilleryMag", 4] call zen_modules_fnc_moduleFireMission
 *
 * Public: No
 */

params ["_vehicles", "_target", "_spread", "_ammo", "_rounds"];

private _position = if (_target isEqualType "") then {
    [_target, true] call CBA_fnc_mapGridToPos;
} else {
    ASLtoAGL getPosASL _target;
};

private _artilleryETA = 1e9;

{
    _artilleryETA = ([_x, _position _ammo] call EFUNC(common,getArtilleryETA)) min _artilleryETA;
} forEach _vehicles;

if (_artilleryETA == -1) then {
    [LSTRING(ModuleFireMission_NotInRange)] call EFUNC(common,showMessage);
} else {
    {
        [QGVAR(fireArtillery), [_x, _position, _spread, _ammo, _rounds], _x] call CBA_fnc_targetEvent;
    } forEach _vehicles;

    [LSTRING(ModuleFireMission_ArtilleryETA), _artilleryETA toFixed 1] call EFUNC(common,showMessage);
};
