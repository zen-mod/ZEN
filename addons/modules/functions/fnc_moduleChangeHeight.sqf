#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to change the height of an object.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleChangeHeight
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

[LSTRING(ChangeHeight), [
    ["EDIT", [ELSTRING(common,Height_Units), LSTRING(ChangeHeight_Tooltip)], ""]
], {
    params ["_values", "_object"];
    _values params ["_change"];

    private _position = getPosASL _object vectorAdd [0, 0, parseNumber _change];
    _object setPosASL _position;
}, {}, _object] call EFUNC(dialog,create);
