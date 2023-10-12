#include "script_component.hpp"
/*
 * Author: mharis001
 * Executes the given code after the specified number of frames.
 *
 * Arguments:
 * 0: Function <CODE>
 * 1: Arguments <ANY> (default: [])
 * 2: Frames <NUMBER> (default: 0)
 *
 * Return Value:
 * None
 *
 * Example:
 * [{hint "Done!"}, [], 5] call zen_common_fnc_execAfterNFrames
 *
 * Public: No
 */

if (canSuspend) exitWith {
    [FUNC(execAfterNFrames), _this] call CBA_fnc_directCall;
};

params [["_function", {}, [{}]], ["_args", []], ["_frames", 0, [0]]];

if (_frames > 0) exitWith {
    [FUNC(execAfterNFrames), [_function, _args, _frames - 1]] call CBA_fnc_execNextFrame;
};

_args call _function;
