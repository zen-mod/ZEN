#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates the camera position and rotation.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_garage_fnc_updateCamera
 *
 * Public: No
 */

[GVAR(camHelper), [GVAR(camYaw) + 180, -GVAR(camPitch), 0]] call BIS_fnc_setObjectRotation;
GVAR(camHelper) attachTo [GVAR(center), GVAR(helperPos)];

GVAR(camera) setPos (GVAR(camHelper) modelToWorld [0, -GVAR(camDistance), 0]);
GVAR(camera) setVectorDirAndUp [vectorDir GVAR(camHelper), vectorUp GVAR(camHelper)];
