#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates the curator camera based on settings.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_camera_fnc_updateSettings
 *
 * Public: No
 */

if (isNull curatorCamera) exitWith {};

curatorCamera camCommand format ["atl %1", ["off", "on"] select GVAR(followTerrain)];
curatorCamera camCommand format ["surfaceSpeed %1", ["off", "on"] select GVAR(adaptiveSpeed)];

curatorCamera camCommand format ["speedDefault %1", GVAR(defaultSpeedCoef)];
curatorCamera camCommand format ["speedMax %1", GVAR(fastSpeedCoef)];

curatorCamera camCommand "maxPitch 89";
