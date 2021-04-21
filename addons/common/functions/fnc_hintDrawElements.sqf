#include "script_component.hpp"
/*
 * Author: Ampersand
 * Draws hint lines and icons in GVAR(hintElements)
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_common_fnc_hintDrawElements
 *
 * Public: No
 */

if (GVAR(hintEHID) != -1) exitWith {};

GVAR(hintEHID) = addMissionEventHandler ["Draw3D", {
    if (GVAR(hintElements) isEqualTo []) exitWith {
        removeMissionEventHandler ["Draw3D", GVAR(hintEHID)];
        GVAR(hintEHID) = -1;
    };
    {
        _x params ["_endTime", "_elementParams"];
        // Icon: [texture, color, position, width, height, angle, text, shadow, textSize, font, textAlign, drawSideArrows, offsetX, offsetY]
        // Line: [start, end, color]
        if (CBA_missionTime > _endTime) then {
            GVAR(hintElements) deleteAt _forEachIndex;
        } else {
            _elementParams params ["_p0", "_p1", "_p2"];

            private _drawParams = _elementParams + [];
            if (_p0 isEqualType "") then {
                // Icon
                if (_p2 isEqualType objNull) then {
                    _drawParams set [2, ASLToAGL aimPos _p2];
                };
                drawIcon3D _drawParams;
            } else {
                // line
                if (_p0 isEqualType objNull) then {
                    _drawParams set [0, ASLToAGL aimPos _p0];
                };
                if (_p1 isEqualType objNull) then {
                    _drawParams set [1, ASLToAGL aimPos _p1];
                };
                drawLine3D _drawParams;
            };
        };
    } forEach GVAR(hintElements);
}];
