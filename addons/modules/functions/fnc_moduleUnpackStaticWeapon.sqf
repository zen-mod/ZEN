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

if (units _gunner findIf {isPlayer _x} != -1) exitWith {
    [LSTRING(ModuleUnpackStaticWeapon_Player)] call EFUNC(common,showMessage);
};

private _backpack = backpack _gunner;
if (_backpack isEqualTo "") exitWith {
    [LSTRING(ModuleUnpackStaticWeapon_Unit)] call EFUNC(common,showMessage);
};

private _assembleInfo = ["assembleTo", "base", "displayName", "dissasembleTo", "primary"] apply {(configOf backpackContainer _gunner >> "assembleInfo" >> _x) call BIS_fnc_getCfgData};
_assembleInfo params ["_assembleTo", "_compatibleBases", "_displayName", "_dissasembleTo", "_primary"];
if (_compatibleBases isEqualType "") then {_compatibleBases = [];};

if (_primary == 1 && {_compatibleBases isEqualTo [] || {_compatibleBases isEqualTo "" || {_compatibleBases isEqualTo [""]}}}) then {
    // Single-backpack weapon
    [_gunner, {
        params ["_successful", "_gunner", "_position"];
        if (_successful) then {
            _gunner setVariable [QGVAR(unpackStaticWeaponTargetPos), _position];

            _gunner addEventHandler ["WeaponAssembled", {
                params ["_gunner", "_weapon"];

                _gunner removeEventHandler ["WeaponAssembled", _thisEventHandler];
                [QEGVAR(common,addObjects), [[_weapon]]] call CBA_fnc_serverEvent;

                private _targetPos = _gunner getVariable [QGVAR(unpackStaticWeaponTargetPos), []];
                if (!(_targetPos isEqualTo [])) then {
                    _weapon setDir (_weapon getDir _targetPos);
                    _gunner doWatch _targetPos;
                };

                // Added due to occassional tripod leg clipping through ground
                _weapon setPosASL (getPosASL _weapon vectorAdd [0, 0, 0.05]);
                _weapon setVectorUp surfaceNormal position _weapon;

                if (unitIsUAV _weapon) exitWith {
                    _gunner connectTerminalToUAV _weapon;
                };

                if (isNull gunner _weapon) exitWith {
                    _gunner assignAsGunner _weapon;
                    _gunner moveInGunner _weapon;

                    group _gunner addVehicle _weapon;
                };
            }];

            _gunner action ["Assemble"];
        };
    }, [], LSTRING(ModuleUnpackStaticWeapon_Direction)] call EFUNC(common,selectPosition);
} else {
    // Two-backpack weapon
    private _backpackers = units _gunner select {!(backpack _x isEqualTo "")};
    private _assistant = objNull;
    {
        if (
            // Has matching backpack
            (backpack _x in _compatibleBases || {_backpack in ((configOf backpackContainer _x >> "assembleInfo" >> "base") call BIS_fnc_getCfgData)})
            // Closer than current
            && {_assistant == objNull || {(_gunner distance _x) < (_gunner distance _assistant)}}
        ) then {
            _assistant = _x;
        };
    } forEach _backpackers;

    if (isNull _assistant) exitWith {
        [LSTRING(ModuleUnpackStaticWeapon_Group)] call EFUNC(common,showMessage);
    };

    if (_assistant distance _gunner > 100) exitWith {
        [LSTRING(ModuleUnpackStaticWeapon_Distance)] call EFUNC(common,showMessage);
    };

    // Get target position
    [_gunner, {
        params ["_successful", "_gunner", "_position", "_assistant"];
        if (_successful) then {
            [QEGVAR(ai,unpackStaticWeapon), [_gunner, _assistant, ASLToAGL _position], _gunner] call CBA_fnc_targetEvent;
        };
}, _assistant, LSTRING(ModuleUnpackStaticWeapon_Direction)] call EFUNC(common,selectPosition);
};
