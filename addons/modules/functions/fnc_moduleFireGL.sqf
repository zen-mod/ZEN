#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to make unit use GL to fire a HE 40mm.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleFireGL
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

// Check if unit has GL
private _weapons = weapons _unit;
private _glMuzzles = [];
{
    private _weapon = _x;
    {
        private _muzzle = _x;
        if (configName inheritsFrom (configFile >> "CfgWeapons" >> _weapon >> _muzzle) isEqualTo "UGL_F") then {
            _glMuzzles pushBack [_weapon, _muzzle];
        };
    } forEach getArray(configFile >> "cfgWeapons" >> _weapon >> "muzzles");
} forEach _weapons;

if (_glMuzzles isEqualTo []) exitWith {
    ["Unit must have GL"] call EFUNC(common,showMessage);
};

// Get target position
[_unit, {
    params ["_successful", "_unit", "_mousePosASL"];
    if (_successful) then {
        private _weapons = weapons _unit;
        private _glMuzzles = [];
        {
            private _weapon = _x;
            {
                private _muzzle = _x;
                if (configName inheritsFrom (configFile >> "CfgWeapons" >> _weapon >> _muzzle) isEqualTo "UGL_F") then {
                    _glMuzzles pushBack [_weapon, _muzzle];
                };
            } forEach getArray(configFile >> "cfgWeapons" >> _weapon >> "muzzles");
        } forEach _weapons;

        if (_glMuzzles isEqualTo []) exitWith {
            [objNull, format ["Unit has no GL: %1", _unit]] call bis_fnc_showCuratorFeedbackMessage;
        };

        private _magazine = "1Rnd_HE_Grenade_shell";
        private _muzzle = _glMuzzles # 0 # 1;
        private _firemode = "Single";
        [_unit, _magazine, _muzzle, _firemode, _mousePosASL] call zen_modules_fnc_projectiles_zeus;
    };
}, [], LSTRING(ModuleFireGL)] call EFUNC(common,selectPosition);
