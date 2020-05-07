#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to toggle the ballistic trajectory of projectile modules.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleToggleThrowTrajectory
 *
 * Public: No
 */

params ["_logic"];

deleteVehicle _logic;

private _throwFlatTrajectory = profileNamespace getVariable ["amp_projectiles_throwFlatTrajectory", true];
_throwFlatTrajectory = !_throwFlatTrajectory;
profileNamespace setVariable ["amp_projectiles_throwFlatTrajectory", _throwFlatTrajectory];
[format ["Throw Trajectory: %1", ["High", "Flat"] select _throwFlatTrajectory]] call EFUNC(common,showMessage);