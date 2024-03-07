#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to send AI communication over chat.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleChatter
 *
 * Public: No
 */

params ["_logic"];

private _unit = effectiveCommander attachedTo _logic;
deleteVehicle _logic;

if (!isNull _unit) exitWith {[_unit] call FUNC(moduleChatterUnit);};

[LSTRING(ModuleChatter), [
    ["EDIT", LSTRING(ModuleChatter_Message), "", true],
    ["SIDES", ELSTRING(common,Side), west]
], {
    params ["_dialogValues"];
    _dialogValues params ["_message", "_side"];

    if (_message == "") exitWith {};

    // Send message from HQ is using side
    [QEGVAR(common,sideChat), [[_side, "HQ"], _message]] call CBA_fnc_globalEvent;
}] call EFUNC(dialog,create);

