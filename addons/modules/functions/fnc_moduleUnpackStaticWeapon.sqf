#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to unpack and assemble a static weapon from supported backpacks.
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

private _fnc_getCompatibleBases = {
    params ["_backpack"];
    private _cfgBase = configFile >> "CfgVehicles" >> _backpack >> "assembleInfo" >> "base";
    [getArray _cfgBase, [getText _cfgBase]] select (isText _cfgBase)
};

private _backpack = backpack _gunner;

if (_backpack isEqualTo "") exitWith {
    [LSTRING(ModuleUnpackStaticWeapon_Unit)] call EFUNC(common,showMessage);
};

private _compatibleBases = [_backpack] call _fnc_getCompatibleBases;
if (_compatibleBases isEqualType "") then {_compatibleBases = [_compatibleBases];};

private _backpackers = units _gunner select {!(backpack _x isEqualTo "")};
private _assistant = {
    if (backpack _x in _compatibleBases) exitWith {_x};
    if (_backpack in ([backpack _x] call _fnc_getCompatibleBases)) exitWith {_x};

    objNull
} forEach _backpackers;

if (_assistant isEqualTo objNull) exitWith {
    [LSTRING(ModuleUnpackStaticWeapon_Group)] call EFUNC(common,showMessage);
};

// Get target position
[_gunner, {
    params ["_successful", "_gunner", "_mousePosASL", "_assistant"];
    [QEGVAR(ai,unpackStaticWeapon), [_gunner, _assistant, ASLToAGL _mousePosASL], _gunner] call CBA_fnc_targetEvent;
}, _assistant, "Static Weapon Facing"] call EFUNC(common,selectPosition);
