/*
 * Author: mharis001
 * Zeus module function to change the fly height of an aircraft.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleFlyHeight
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

if !(_vehicle isKindOf "Air") exitWith {
    [LSTRING(OnlyAircraft)] call EFUNC(common,showMessage);
};

if !(alive _vehicle) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

[LSTRING(ModuleFlyHeight), [
    ["SLIDER", [ELSTRING(common,Height_Units), LSTRING(ModuleFlyHeight_Tooltip)], [0, 9999, 100, 0]]
], {
    params ["_dialogValues", "_vehicle"];
    _dialogValues params ["_height"];

    [QEGVAR(common,flyInHeight), [_vehicle, _height], _vehicle] call CBA_fnc_targetEvent;
}, {}, _vehicle] call EFUNC(dialog,create);
