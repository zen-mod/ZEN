#include "script_component.hpp"
/*
 * Authors: Timi007
 * Aggregate elements from each of the N arrays. The i-th array contains the i-th element from each of the argument arrays.
 * Works similar to the Python zip(*iterables) function.
 *
 * Arguments:
 * 0: Arrays to zip each containing a subarray <ARRAY<ARRAY>>
 *
 * Return Value:
 * Aggregate elements from each of the arrays. <ARRAY>
 *
 * Example:
 * [[[-1, -2, -3], [1, 2, 3]]] call zen_common_fnc_zip
 * => [[-1, 1], [-2, 2], [-3, 3]]
 *
 * Public: No
 */

params [["_iterables", [], [[]]]];

if (_iterables isEqualTo []) exitWith {[]};

private _minCount = -1;
{
    if (_minCount < 0 || count _x < _minCount) then {
        _minCount = count _x;
    };
} forEach _iterables;

if (_minCount <= 0) exitWith {[]};

private _result = [];

for "_i" from 0 to (_minCount - 1) do {
    private _temp = [];
    {
        _temp pushBack (_x select _i);
    } forEach _iterables;

    _result pushBack _temp;
};

_result
