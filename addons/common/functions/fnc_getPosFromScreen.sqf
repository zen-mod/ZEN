#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns a world position based on the given screen position.
 * Can attempt to find a flat position on an intersecting surface if enabled.
 *
 * Arguments:
 * 0: Screen Position <ARRAY> (default: getMousePosition)
 * 1: Check Intersections <BOOL|NUMBER> (default: true)
 *   - 0, false: Do not check for intersections, return position on terrain.
 *   - 1, true:  Check for intersections with surfaces.
 *   - 2:        Check for intersections and attempt to find a flat surface.
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

params [["_screenPos", getMousePosition, [[]], 2], ["_checkIntersections", true, [true, 0]]];

if (_checkIntersections isEqualType true) then {
    _checkIntersections = parseNumber _checkIntersections;
};

if (visibleMap) then {
    private _ctrlMap = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    AGLToASL (_ctrlMap posScreenToWorld _screenPos)
} else {
    private _position = AGLToASL screenToWorld _screenPos;

    switch (_checkIntersections) do {
        case 0: {
            _position
        };
        case 1: {
            lineIntersectsSurfaces [getPosASL curatorCamera, _position] param [0, []] param [0, _position]
        };
        case 2: {
            {
                _x params ["_intersectPos", "_surfaceNormal"];

                // Always keep the first intersection as a fallback
                if (_forEachIndex == 0) then {
                    _position = _intersectPos;
                };

                // Use the intersection position if the surface is relatively flat
                if (_surfaceNormal vectorDotProduct [0, 0, 1] > 0.5) exitWith {
                    _position = _intersectPos;
                };
            } forEach lineIntersectsSurfaces [getPosASL curatorCamera, _position, objNull, objNull, true, MAX_RESULTS, "VIEW", "FIRE", false];

            _position
        };
    };
};
