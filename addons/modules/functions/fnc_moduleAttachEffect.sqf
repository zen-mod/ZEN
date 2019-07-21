#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to attach an effect to infantry.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Target <NUMBER>
 * 2: Effect <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, 0, "Chemlight_Blue"] call zen_modules_fnc_moduleAttachEffect
 *
 * Public: No
 */

params ["_logic", "_target", "_effectType"];

private _units = if (_target == -1) then {
    (units attachedTo _logic) select {alive _x};
} else {
    private _side = [west, east, independent, civilian] select _target;
    allUnits select {alive _x && {side _x == _side}};
};

{
    private _effect = _x getVariable [QGVAR(effect), objNull];
    detach _effect;

    // Hack for deleting IR Strobe effect
    _effect setPosASL (getPosASL _effect vectorAdd [0, 0, -1000]);
    [{deleteVehicle _this}, _effect, 2] call CBA_fnc_waitAndExecute;
} forEach _units;

if (_effectType == "") exitWith {};

{
    private _effect = _effectType createVehicle [0, 0, 0];
    _effect attachTo [_x, [0.05, -0.09, 0.1], "LeftShoulder"];
    _x setVariable [QGVAR(effect), _effect, true];
} forEach _units;
