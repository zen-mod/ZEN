#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to make unit fire unguided rocket launcher.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleFireLauncher
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

// Check if unit has launcher
private _launcher = secondaryWeapon _unit;
if (_launcher isEqualTo "") exitWith {
    ["Unit must have launcher"] call EFUNC(common,showMessage);
};

// Get target position
[_unit, {
    params ["_successful", "_unit", "_mousePosASL"];
    if (_successful) then {
        private _weapon = secondaryWeapon _unit;

        private _magazine = getArray (configFile >> "CfgWeapons" >> _weapon >> "Magazines") # 0;

        private _muzzle = _weapon;
        private _firemode = "Single";
        [_unit, _magazine, _muzzle, _firemode, _mousePosASL] call zen_modules_fnc_projectiles_zeus;
    };
}, [], LSTRING(ModuleFireLauncher)] call EFUNC(common,selectPosition);
