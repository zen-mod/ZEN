#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to attach an object to another.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_attached_objects_fnc_module
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(PlaceOnObject)] call EFUNC(common,showMessage);
};

// Start attaching if not already attached, otherwise detach
if (isNull attachedTo _object) then {
    [_object] call FUNC(attach);
} else {
    [_object] call FUNC(detach);
};
