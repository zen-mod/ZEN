#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create a LZ logic.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleCreateLZ
 *
 * Public: No
 */

params ["_logic"];

[LSTRING(ModuleCreateLZ), [
    [
        "EDIT",
        LSTRING(ModuleCreateLZ_Name),
        [_logic, LSTRING(ModuleCreateLZ_Format)] call EFUNC(position_logics,nextName),
        true
    ]
], {
    params ["_values", "_logic"];
    _values params ["_name"];

    private _helipad = createVehicle ["Land_HelipadEmpty_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
    _helipad setVariable [QEGVAR(position_logics,delete), true, true];
    _helipad attachTo [_logic, [0, 0, 0]];

    [_logic, _name] call EFUNC(position_logics,add);
}, {
    params ["", "_logic"];

    deleteVehicle _logic;
}, _logic] call EFUNC(dialog,create);
