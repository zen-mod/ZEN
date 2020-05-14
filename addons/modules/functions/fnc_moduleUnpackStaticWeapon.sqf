#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to use backpacks to assemble a static weapon
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleUnpackStaticWeapon
 *
 * Public: No
 */

params ["_logic"];

private _gunner = attachedTo _logic;
deleteVehicle _logic;

if (isNull _gunner) exitWith {
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

if !(_gunner isKindOf "CAManBase") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if !(alive _gunner) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

if (isPlayer _gunner) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call EFUNC(common,showMessage);
};

getCompatibleBases = {
	params ["_backpack"];
	private _cfgBase = configFile >> "CfgVehicles" >> _backpack >> "assembleInfo" >> "base";
	private _compatibleBases = if (isText _cfgBase) then {[getText _cfgBase]} else {getArray _cfgBase};
	_compatibleBases
};

private _backpack = backpack _gunner;

if (_backpack isEqualTo "") exitWith {
    ["Unit must carry a weapon bag"] call EFUNC(common,showMessage);
};

private _compatibleBases = [_backpack] call getCompatibleBases;
if (_compatibleBases isEqualType "") then {_compatibleBases = [_compatibleBases];};

private _backpackers = units _gunner select {!(backpack _x isEqualTo "")};
private _assistant = {
	if (backpack _x in _compatibleBases) exitWith {_x};
	if (_backpack in ([backpack _x] call getCompatibleBases)) exitWith {_x};
	
	objNull
} forEach _backpackers;

if (_assistant isEqualTo objNull) exitWith {
    ["Unit group must contain two compatible weapon bags"] call EFUNC(common,showMessage);
};

// Get target position
[_gunner, {
	params ["_successful", "_gunner", "_mousePosASL", "_assistant"],;
	[_gunner, _assistant, ASLToAGL _mousePosASL] remoteExecCall ["zen_modules_fnc_unpackStaticWeapon", _gunner];
}, _assistant, "Static Weapon Facing"] call EFUNC(common,selectPosition);
