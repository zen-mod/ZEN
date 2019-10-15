#include "script_component.hpp"
/*
 * Author: mharis001
 * Applies the customization of the current garage vehicle
 * to all selected vehicles of the same type.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_garage_fnc_applyToAll
 *
 * Public: No
 */

(GVAR(center) call BIS_fnc_getVehicleCustomization) params ["_texture", "_animations"];

private _vehicleType = typeOf GVAR(center);

{
    if (typeOf _x isEqualTo _vehicleType) then {
        [_x, _texture, _animations, true] call BIS_fnc_initVehicle;
    };
} forEach SELECTED_OBJECTS;
