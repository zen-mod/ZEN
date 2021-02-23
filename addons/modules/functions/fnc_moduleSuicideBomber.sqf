#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to make a unit a suicide bomber.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleSuicideBomber
 *
 * Public: No
 */

#define EXPLOSIVES ["R_TBG32V_F", "M_Mo_120mm_AT", "Bo_GBU12_LGB"]
#define DISTANCE_FAR 15
#define DISTANCE_CLOSE 2
#define MOVE_TIME 10
#define SCANNING_PERIOD 1

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

if (!alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

if !(_unit isKindOf "CAManBase") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if (isPlayer _unit) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call EFUNC(common,showMessage);
};

if (_unit getVariable [QGVAR(isBomber), false]) exitWith {
    [LSTRING(ModuleSuicideBomber_AlreadyBomber)] call EFUNC(common,showMessage);
};

[LSTRING(ModuleSuicideBomber), [
    ["SIDES", LSTRING(ActivationSide), west],
    ["SLIDER:RADIUS", LSTRING(ActivationRadius), [5, 50, 10, 0, _unit, [1, 0, 0, 0.7]]],
    ["TOOLBOX", LSTRING(ExplosionSize), [0, 1, 3, ["str_small", ELSTRING(common,Medium), "str_large"]]],
    ["TOOLBOX:YESNO", LSTRING(ModuleSuicideBomber_DeadManSwitch), false],
    ["TOOLBOX:YESNO", [LSTRING(ModuleSuicideBomber_AutoSeek), LSTRING(ModuleSuicideBomber_AutoSeek_Tooltip)], false]
], {
    params ["_dialogValues", "_unit"];
    _dialogValues params ["_activationSide", "_activationRadius", "_explosionSize", "_deadManSwitch", "_autoSeek"];

    // Prevent another Suicide Bomber module from being attached
    _unit setVariable [QGVAR(isBomber), true, true];

    // One time behaviour changes for auto seek
    if (_autoSeek) then {
        [QGVAR(autoSeekBehavior), _unit, _unit] call CBA_fnc_targetEvent;
    };

    // Add PFH to make unit a suicide bomber
    [{
        params ["_args", "_pfhID"];
        _args params ["_unit", "_activationSide", "_activationRadius", "_explosionSize", "_deadManSwitch", "_autoSeek"];

        // Unit deleted or killed without dead man's switch, remove PFH
        if (isNull _unit || {!alive _unit && {!_deadManSwitch}}) then {
            [_pfhID] call CBA_fnc_removePerFrameHandler;
        };

        // Support for ace unconsciousness
        private _unconscious = _unit getVariable ["ACE_isUnconscious", false];

        // Cannot detonate if unit is unconscious and no dead man's switch
        if (_unconscious && {!_deadManSwitch}) exitWith {};

        // Check detonation conditions
        if (
            _deadManSwitch && {_unconscious || {!alive _unit}} || {
                (_unit nearObjects _activationRadius) findIf {
                    side group _x == _activationSide && {_x != _unit} && {alive _x}
                } != -1
            }
        ) then {
            createVehicle [EXPLOSIVES select _explosionSize, _unit, [], 0, "CAN_COLLIDE"];
            [_pfhID] call CBA_fnc_removePerFrameHandler;
        };

        // Handle auto seek behaviour
        if (!_autoSeek) exitWith {};

        private _range = 100 + 100 * (_unit skillFinal "spotDistance"); // 100-200
        private _nearestObjects = nearestObjects [_unit, [], _range];
        private _index = _nearestObjects findIf {side group _x == _activationSide && {_x != _unit} && {alive _x}};

        if (_index == -1) exitWith {};

        private _memory = _unit getVariable [QGVAR(bomberMemory), [nil, CBA_missionTime]];
        _memory params ["_lastMove", "_nextTime"];

        // Get random position close to target to avoid bug where AI wont path to a certain position
        private _moveToPos = (_nearestObjects select _index) getPos [1, random 360];

        if (isNil "_lastMove" || // No move given yet
            {_lastMove distance _moveToPos > DISTANCE_FAR} || // New target is too far from last move
            {_lastMove distance _unit < DISTANCE_CLOSE} || // Unit has reached last move
            {CBA_missionTime >= _nextTime} // Too much time passed between last move (also acts as a fail-safe if unit gets stuck)
        ) then {
            [QEGVAR(common,doMove), [_unit, _moveToPos], _unit] call CBA_fnc_targetEvent;
            _unit setVariable [QGVAR(bomberMemory), [_moveToPos, CBA_missionTime + MOVE_TIME]];
        };
    }, SCANNING_PERIOD, [_unit, _activationSide, _activationRadius, _explosionSize, _deadManSwitch, _autoSeek]] call CBA_fnc_addPerFrameHandler;
}, {}, _unit] call EFUNC(dialog,create);
