#include "script_component.hpp"
/*
 * Author: Eclipser
 * Toggles the ACE Captives handcuffed state of the given units.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call zen_context_actions_fnc_toggleCaptive
 *
 * Public: No
 */

{
    if (alive _x && {_x isKindOf "CAManBase"}) then {
        private _handcuffed = _x getVariable ["ace_captives_isHandcuffed", false];
        ["ace_captives_setHandcuffed", [_x, !_handcuffed], _x] call CBA_fnc_targetEvent;
    };
} forEach _this;
