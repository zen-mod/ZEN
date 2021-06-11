#include "script_component.hpp"
/*
 * Author: mharis001
 * Makes the given unit or group perform suppressive fire on the target
 * for the specified amount of time.
 *
 * Arguments:
 * 0: Unit or Group <OBJECT|GROUP>
 * 1: Target <OBJECT|ARRAY>
 *   - Position must be in ATL format.
 * 2: Duration <NUMBER> (default: 20)
 * 3: Stance <STRING> (default: "AUTO")
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, _target, 20, "MIDDLE"] call zen_ai_fnc_suppressiveFire
 *
 * Public: No
 */

#define DISABLED_ABILITIES ["AIMINGERROR", "AUTOTARGET", "FSM", "PATH", "SUPPRESSION", "TARGET"]
#define TARGETING_DELAY 3

params [
    ["_unit", objNull, [objNull, grpNull]],
    ["_target", [0, 0, 0], [[], objNull], 3],
    ["_duration", 20, [0]],
    ["_stance", "AUTO", [""]]
];

if (!local _unit) exitWith {
    [QGVAR(suppressiveFire), _this, _unit] call CBA_fnc_targetEvent;
};

if (_unit isEqualType grpNull) exitWith {
    {
        [_x, _target, _duration, _stance] call FUNC(suppressiveFire);
    } forEach units _unit;
};

// If a vehicle is given directly, use its gunner as the unit
if !(_unit call CBA_fnc_isPerson) then {
    _unit = gunner _unit;
};

if (
    !alive _unit
    || {isPlayer _unit}
    || {!(lifeState _unit in ["HEALTHY", "INJURED"])}
    || {
        private _vehicle = vehicle _unit;

        if (_vehicle == _unit || {_unit call EFUNC(common,isUnitFFV)}) then {
            currentWeapon _unit == ""
        } else {
            _vehicle weaponsTurret (_vehicle unitTurret _unit) isEqualTo []
        };
    }
) exitWith {};

// Disable AI abilities to make units more responsive to commands
private _abilities = DISABLED_ABILITIES apply {_unit checkAIFeature _x};
{_unit disableAI _x} forEach DISABLED_ABILITIES;

// Without maximum skill, AI do not reliably target objects at long range
// This does make them very accurate at close range but this is not a big issue
private _skills = AI_SUB_SKILLS apply {_unit skill _x};
_unit setSkill 1;

// Set the unit's behaviour to COMBAT to make them raise their weapon and aim at the target
private _behaviour = combatBehaviour _unit;
_unit setCombatBehaviour "COMBAT";

// Set the unit's combat mode to BLUE to make them hold their fire
// The unit will still track the target but only fire when told to
private _combatMode = unitCombatMode _unit;
_unit setUnitCombatMode "BLUE";

// Apply the specified stance
private _unitPos = unitPos _unit;
_unit setUnitPos _stance;

// Create a temporary target object if one is not given (needed for the doTarget command)
private _isTempTarget = _target isEqualType [];

if (_isTempTarget) then {
    // Using Logic or Module_F doesn't work well. At best, AI will loosely target those objects
    // However, they will realiably and accurately target this object type
    _target = createVehicle ["CBA_B_InvisibleTargetVehicle", _target, [], 0, "CAN_COLLIDE"];
};

// Make the unit aim and track the target
_unit reveal [_target, 4];
_unit doWatch _target;
_unit lookAt _target;
_unit doTarget _target;

// Force the unit to fire their weapon for the specified duration. Works better than using the doSuppressiveFire
// command which does not make units realiably fire at the target, especially at longer distances. Small initial
// delay to give units time to aim at the target. We ignore reloading and give units infinite ammo to create a
// more convincing suppressive fire effect
private _endTime = CBA_missionTime + _duration + TARGETING_DELAY;

[{
    [{
        params ["_unit", "_target", "_isTempTarget", "_abilities", "_skills", "_behaviour", "_combatMode", "_unitPos", "_shotTime", "_endTime"];

        if (
            !alive _unit
            || {isNull _target}
            || {CBA_missionTime >= _endTime}
        ) exitWith {
            // Delete temporary target object
            if (_isTempTarget) then {
                deleteVehicle _target;
            };

            // Restore AI abilities, skills, behaviour, combat mode, stance, and targeting
            {
                if (_x) then {
                    _unit enableAI (DISABLED_ABILITIES select _forEachIndex);
                };
            } forEach _abilities;

            {
                _unit setSkill [AI_SUB_SKILLS select _forEachIndex, _x];
            } forEach _skills;

            _unit setCombatBehaviour _behaviour;
            _unit setUnitCombatMode _combatMode;
            _unit setUnitPos _unitPos;
            _unit doWatch objNull;
            _unit lookAt objNull;

            true // Exit
        };

        if (CBA_missionTime >= _shotTime) then {
            private _vehicle = vehicle _unit;

            if (_vehicle == _unit) exitWith {
                weaponState _unit params ["_weapon", "_muzzle", "_fireMode"];

                _unit setAmmo [_weapon, 1e6];
                _unit forceWeaponFire [_muzzle, _fireMode];
                _this set [8, CBA_missionTime + 0.1];
            };

            if (_unit call EFUNC(common,isUnitFFV)) exitWith {
                // Using UseMagazine action since forceWeaponFire command does not work for FFV units
                // UseMagazine action doesn't seem to work with currently loaded magazine (currentMagazineDetail)
                // Therefore, this relies on the unit having an extra magazine in their inventory
                // but should be fine in most situations
                private _weapon = currentWeapon _unit;
                private _compatibleMagazines = _weapon call CBA_fnc_compatibleMagazines;
                private _index = magazines _unit findIf {_x in _compatibleMagazines};
                if (_index == -1) exitWith {};

                private _magazine = magazinesDetail _unit select _index;
                _magazine call EFUNC(common,parseMagazineDetail) params ["_id", "_owner"];

                _unit setAmmo [_weapon, 1e6];
                CBA_logic action ["UseMagazine", _unit, _unit, _owner, _id];
                _this set [8, CBA_missionTime + 0.1];
            };

            private _turretPath = _vehicle unitTurret _unit;
            private _muzzle = weaponState [_vehicle, _turretPath] select 1;
            _unit setAmmo [_muzzle, 1e6];

            // Get the reload time for the current weapon state
            weaponState [_vehicle, _turretPath] params ["_weapon", "_muzzle", "_fireMode", "_magazine", "_ammo"];

            private _config = configFile >> "CfgWeapons" >> _weapon;

            if (_muzzle != _weapon) then {
                _config = _config >> _muzzle;
            };

            if (_muzzle != _fireMode) then {
                _config = _config >> _fireMode;
            };

            private _reloadTime = getNumber (_config >> "reloadTime");

            // Find the correct magazine id and owner and force the weapon to fire
            {
                _x params ["_xMagazine", "_xTurretPath", "_xAmmo", "_id", "_owner"];

                if (_xTurretPath isEqualTo _turretPath && {_xMagazine == _magazine && {_xAmmo == _ammo && {_xAmmo != 0}}}) exitWith {
                    _vehicle action ["UseMagazine", _vehicle, _unit, _owner, _id];
                    _this set [8, CBA_missionTime + _reloadTime];
                };
            } forEach magazinesAllTurrets _vehicle;
        };

        false // Continue
    }, {}, _this] call CBA_fnc_waitUntilAndExecute;
}, [_unit, _target, _isTempTarget, _abilities, _skills, _behaviour, _combatMode, _unitPos, 0, _endTime], TARGETING_DELAY] call CBA_fnc_waitAndExecute;
