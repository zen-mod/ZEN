#include "script_component.hpp"
/*
 * Authors: Timi007
 * Checks if the given point is inside the defined cylinder.
 *
 * Arguments:
 * 0: Start position of cylinder <ARRAY>
 * 1: End position of cylinder <ARRAY>
 * 2: Radius of cylinder <NUMBER>
 * 3: Point to check <ARRAY>
 *
 * Return Value:
 * Position is in cylinder <BOOL>
 *
 * Example:
 * [[0, 0, 0], [100, 0, 0], 50, [50, 50, 0]] call zen_plotting_fnc_isPosInCylinder
 *
 * Public: No
 */

params ["_p1", "_p2", "_r", "_q"];
// https://stackoverflow.com/a/47933302

private _diff = _p2 vectorDiff _p1;

((_q vectorDiff _p1) vectorDotProduct _diff >= 0)    // First test (q - p1) * (p2 - p1) >= 0
|| {(_q vectorDiff _p2) vectorDotProduct _diff <= 0} // Second test (q - p2) * (p2 - p1) <= 0
|| {(vectorMagnitude ((_q vectorDiff _p1) vectorCrossProduct _diff)) <= (_r * vectorMagnitude _diff)} // Third test |(q - p1) x (p2 - p1)| <= r * |p2 - p1|
