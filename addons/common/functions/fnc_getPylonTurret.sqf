#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the turret path that owns the given pylon.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Pylon Index <NUMBER>
 *
 * Return Value:
 * Turret Path <ARRAY>
 *
 * Example:
 * [_vehicle, 0] call zen_common_fnc_getPylonTurret
 *
 * Public: No
 */

params ["_vehicle", "_pylonIndex"];

getAllPylonsInfo _vehicle param [_pylonIndex, []] param [2, [-1]]
