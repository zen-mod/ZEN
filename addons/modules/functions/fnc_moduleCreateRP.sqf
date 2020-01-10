#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create a RP logic.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleCreateRP
 *
 * Public: No
 */

params ["_logic"];

[LSTRING(ModuleCreateRP), [
    [
        "EDIT",
        LSTRING(ModuleCreateRP_Name),
        [_logic, LSTRING(ModuleCreateRP_Format)] call EFUNC(position_logics,nextName),
        true
    ]
], {
    params ["_values", "_logic"];
    _values params ["_name"];

    [_logic, _name] call EFUNC(position_logics,add);
}, {
    params ["", "_logic"];

    deleteVehicle _logic;
}, _logic] call EFUNC(dialog,create);
