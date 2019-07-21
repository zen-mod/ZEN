#include "script_component.hpp"
/*
 * Author: mharis001
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
    getPosASL _target;
};

private _artilleryETA = 9999;

{
    _artilleryETA = (_x getArtilleryETA [_position, _ammo]) min _artilleryETA;
} forEach _vehicles;

if (_artilleryETA == -1) then {
    [LSTRING(ModuleFireMission_NotInRange)] call EFUNC(common,showMessage);
} else {
    {
        private _targetPos = [_position, _spread] call CBA_fnc_randPos;
        [QEGVAR(common,doArtilleryFire), [_x, _targetPos, _ammo, _rounds], _x] call CBA_fnc_targetEvent;
    } forEach _vehicles;

    [LSTRING(ModuleFireMission_ArtilleryETA), _artilleryETA] call EFUNC(common,showMessage);
};
