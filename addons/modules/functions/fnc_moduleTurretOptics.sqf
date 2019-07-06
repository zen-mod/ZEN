/*
 * Author: mharis001
 * Zeus module function to modify the turret optics of a vehicle.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleTurretOptics
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];

private _vehicle = attachedTo _logic;
deleteVehicle _logic;

if (isNull _vehicle) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

if !(_vehicle isKindOf "LandVehicle" || {_vehicle isKindOf "Air"} || {_vehicle isKindOf "Ship"}) exitWith {
    [LSTRING(OnlyVehicles)] call EFUNC(common,showMessage);
};

if !(alive _vehicle) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

[LSTRING(ModuleTurretOptics), [
    ["TOOLBOX", LSTRING(ModuleTurretOptics_NVG), [0, [ELSTRING(common,Unchanged), ELSTRING(common,Disabled), ELSTRING(common,Enabled)]], true],
    ["TOOLBOX", LSTRING(ModuleTurretOptics_TI),  [0, [ELSTRING(common,Unchanged), ELSTRING(common,Disabled), ELSTRING(common,Enabled)]], true]
], {
    params ["_dialogValues", "_vehicle"];
    _dialogValues params ["_nvgEquipment", "_tiEquipment"];

    if (_nvgEquipment > 0) then {
        _vehicle disableNVGEquipment (_nvgEquipment == 1);
    };

    if (_tiEquipment > 0) then {
        _vehicle disableTIEquipment (_tiEquipment == 1);
    };
}, {}, _vehicle] call EFUNC(dialog,create);
