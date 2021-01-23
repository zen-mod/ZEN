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

(GVAR(center) call EFUNC(common,getVehicleCustomization)) params ["_textures", "_animations"];

private _vehicleType = typeOf GVAR(center);

{
    if (typeOf _x isEqualTo _vehicleType) then {
        [_x, _textures, _animations, true, false] call EFUNC(common,customizeVehicle);
    };
} forEach SELECTED_OBJECTS;
