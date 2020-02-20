#include "script_component.hpp"
/*
 * Author: mharis001
 * Toggles the state of the Zeus camera flashlight.
 *
 * Arguments:
 * 0: State <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true] call zen_flashlight_fnc_toggle
 *
 * Public: No
 */

params ["_state"];

if (_state) then {
    GVAR(light) = "#lightpoint" createVehicleLocal [0, 0, 0];
	GVAR(light) setLightBrightness LIGHT_INTENSITY;
	GVAR(light) setLightAmbient [1, 1, 1];
	GVAR(light) setLightColor [0, 0, 0];
    GVAR(light) lightAttachObject [curatorCamera, [0, 0, -7 * LIGHT_INTENSITY]];
} else {
    deleteVehicle GVAR(light);
};
