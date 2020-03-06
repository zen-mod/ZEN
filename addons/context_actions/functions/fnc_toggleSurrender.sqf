#include "script_component.hpp"
/*
 * Author: Eclipser
 * Toggles the ACE Captives surrendering state of the given units.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call zen_context_actions_fnc_toggleSurrender
 *
 * Public: No
 */

{
    if (alive _x && {_x isKindOf "CAManBase"} && {!(_x getVariable ["ace_captives_isHandcuffed", false])}) then {
        private _surrendering = _x getVariable ["ace_captives_isSurrendering", false];
        ["ace_captives_setSurrendered", [_x, !_surrendering], _x] call CBA_fnc_targetEvent;
    };
} forEach _this;
