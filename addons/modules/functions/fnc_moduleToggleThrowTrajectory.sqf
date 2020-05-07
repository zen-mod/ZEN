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

if (isNil "zen_projectiles_throwFlatTrajectory") then {zen_projectiles_throwFlatTrajectory = true;};
zen_projectiles_throwFlatTrajectory = !zen_projectiles_throwFlatTrajectory;
[format ["Throw Trajectory: %1", ["High", "Flat"] select zen_projectiles_throwFlatTrajectory]] call EFUNC(common,showMessage);