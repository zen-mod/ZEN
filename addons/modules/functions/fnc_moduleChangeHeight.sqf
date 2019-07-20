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
#include "script_component.hpp"

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

[LSTRING(ModuleChangeHeight), [
    ["EDIT", [ELSTRING(common,Height_Units), LSTRING(ModuleChangeHeight_Tooltip)], ["", {
        params ["_value"];

        private _filter = toArray "-0123456789";
        toString (toArray _value select {_x in _filter})
    }]]
], {
    params ["_dialogValues", "_object"];
    _dialogValues params ["_changeInHeight"];

    _changeInHeight = parseNumber _changeInHeight;
    _object setPosASL (getPosASL _object vectorAdd [0, 0, _changeInHeight]);
}, {}, _object] call EFUNC(dialog,create);
