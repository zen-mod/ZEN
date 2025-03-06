#include "script_component.hpp"
/*
 * Authors: Timi007
 * Returns the Cartesian product of the given sets.
 * Similar to the itertools.product function in Python.
 *
 * Arguments:
 * 0: N-dimensional sets <ARRAY>
 *
 * Return Value:
 * Cartesian product <ARRAY>
 *
 * Example:
 * [[[-1, 1], [-2, 2], [-3, 3]]] call zen_common_fnc_cartesianProduct
 * => [[-1,-2,-3], [-1,-2,3], [-1,2,-3], [-1,2,3], [1,-2,-3], [1,-2,3], [1,2,-3], [1,2,3]]
 *
 * Public: No
 */

params [["_sets", [], [[]]]];

private _fnc_product = {
    params ["_setA", "_setB"];

    private _result = [];

    {
        private _a = _x;

        if !(_a isEqualType []) then {
            _a = [_a];
        };

        {
            _result pushBack (_a + [_x]);
        } forEach _setB;
    } forEach _setA;

    _result
};

private _result = _sets select 0;
for "_i" from 1 to (count _sets - 1) do {
    _result = [_result, _sets select _i] call _fnc_product;
};

_result
