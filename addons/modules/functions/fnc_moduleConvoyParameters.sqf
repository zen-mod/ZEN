#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to set the convoy parameters of a vehicle.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleConvoyParameters
 *
 * Public: No
 */

params ["_logic"];

private _vehicle = attachedTo _logic;
deleteVehicle _logic;

if (isNull _vehicle) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

if !(_vehicle isKindOf "LandVehicle") exitWith {
    [LSTRING(OnlyVehicles)] call EFUNC(common,showMessage);
};

if !(alive _vehicle) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

[LSTRING(ModuleConvoyParameters), [
    ["SLIDER", [LSTRING(ModuleConvoyParameters_Separation), LSTRING(ModuleConvoyParameters_Separation_Tooltip)], [5, 250, 50, 0]],
    ["SLIDER", [LSTRING(ModuleConvoyParameters_Speed), LSTRING(ModuleConvoyParameters_Speed_Tooltip)], [5, 200, 75, 0]],
    ["TOOLBOX:YESNO", [LSTRING(ModuleConvoyParameters_ForceRoad), LSTRING(ModuleConvoyParameters_ForceRoad_Tooltip)], true]
], {
    params ["_dialogValues", "_vehicle"];
    _dialogValues params ["_separation", "_speedLimit", "_stayOnRoad"];

    [QEGVAR(common,setConvoySeparation), [_vehicle, _separation], _vehicle] call CBA_fnc_targetEvent;
    [QEGVAR(common,limitSpeed), [_vehicle, _speedLimit], _vehicle] call CBA_fnc_targetEvent;
    [QEGVAR(common,forceFollowRoad), [_vehicle, _stayOnRoad], _vehicle] call CBA_fnc_targetEvent;
}, {}, _vehicle] call EFUNC(dialog,create);
