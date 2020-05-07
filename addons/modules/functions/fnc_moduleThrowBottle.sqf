#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to make unit throw a water bottle (ALiVE).
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleThrowBottle
 *
 * Public: No
 */

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

if !(_unit isKindOf "Man") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if !(alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

if !(isClass (ConfigFile >> "CfgMagazines" >> "ALiVE_HandGrenade_Bottle")) exitWith {
    ["ALiVE mod must be loaded"] call EFUNC(common,showMessage);
};

// Get target position
[_unit, {
	params ["_successful", "_unit", "_mousePosASL"];
	private _magazine = "ALiVE_HandGrenade_Bottle";
	private _muzzle = "ALiVE_Handgrenade_BottleMuzzle";
	private _firemode = "ALiVE_Handgrenade_BottleMuzzle";
	[_unit, _magazine, _muzzle, _firemode, _mousePosASL] call zen_modules_fnc_projectiles_zeus;
}, [], LSTRING(ThrowBottle)] call EFUNC(common,selectPosition);
