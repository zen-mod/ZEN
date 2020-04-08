#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns a world position based on the given screen position.
 * Will attempt to find a flat position on an intersecting surface if enabled.
 *
 * Arguments:
 * 0: Screen Position <ARRAY> (default: getMousePosition)
 * 1: Check Intersections <BOOL> (default: true)
 *
 * Return Value:
 * Position ASL <ARRAY>
 *
 * Example:
 * [[0.5, 0.5], true] call zen_common_fnc_getPosFromScreen
 *
 * Public: No
 */

#define MAX_RESULTS 5

params [["_screenPos", getMousePosition, [[]], 2], ["_checkIntersections", true, [true]]];

if (visibleMap) then {
    private _ctrlMap = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    private _pos2D = _ctrlMap ctrlMapScreenToWorld _screenPos;

    AGLtoASL (_pos2D + [0])
} else {
    private _position = AGLtoASL screenToWorld _screenPos;

    if (_checkIntersections) then {
        {
            _x params ["_intersectPos", "_surfaceNormal"];

            // Use the intersection position if the surface is relatively flat
            if (_surfaceNormal vectorDotProduct [0, 0, 1] > 0.5) exitWith {
                _position = _intersectPos;
            };
        } forEach lineIntersectsSurfaces [getPosASL curatorCamera, _position, objNull, objNull, true, MAX_RESULTS, "VIEW", "FIRE", false];
    };

    _position
};
