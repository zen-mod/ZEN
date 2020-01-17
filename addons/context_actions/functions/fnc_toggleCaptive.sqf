#include "script_component.hpp"
/*
 * Author: Eclipser
 * Toggles the ACE captive state of the given units.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit] call zen_context_actions_fnc_toggleCaptive
 *
 * Public: No
 */

private _units = _this select {
    alive _x
    && {_x isKindOf "CAManBase"}
};

{
    private _captive = _x getVariable ["ace_captives_isHandcuffed", false];
    ["ace_captives_setHandcuffed", [_x, !_captive], _x] call CBA_fnc_targetEvent;
} forEach _units;
