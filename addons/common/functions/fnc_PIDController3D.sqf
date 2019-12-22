#include "script_component.hpp"
/*
 * Author: Kex
 * Returns output of a PID controller.
 *
 * Arguments:
 * 0: Error <ARRAY>
 * 1: Variables <ARRAY>
 * 2: Constants <ARRAY>
 *
 * Return Value:
 * Correction and updated variables <ARRAY>
 *
 * Example:
 * _error = [10, 5, 0];
 * _last = [_error];
 * _output = [_error, _last, [0.01, 0.1, 0.1]] call zen_common_fnc_PIDController3D;
 * _output params ["_correction", "_last"];
 *
 * Public: No
 */

params [["_error", [0, 0, 0], [[]], 3], ["_variables", [], [[]]], ["_constants", [], [[]]]];
_variables params [["_lastError", [0, 0, 0], [[]], 3], ["_integral", [0, 0, 0], [[]], 3]];
_constants params [["_kp", 1 [0]], ["_ki", 1 [0]], ["_kd", 1, [0]]];

_integral = _integral vectorAdd _error;
private _diff = _error vectorDiff _lastError;
private _p = _error vectorMultiply _kp;
private _i = _integral vectorMultiply _ki;
private _d = _diff vectorMultiply _kd;
private _correction = _p vectorAdd _i vectorAdd _d;

[_correction, [_error, _integral]]
