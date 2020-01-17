#include "script_component.hpp"
/*
 * Author: Eclipser
 * Toggles the ACE surrendering state of the given units.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit] call zen_context_actions_fnc_toggleSurrender
 *
 * Public: No
 */

private _units = _this select {
    alive _x
    && {_x isKindOf "CAManBase"}
    && {!(_x getVariable ["ace_captives_isHandcuffed", false])}
};

{
    private _surrendering = _x getVariable ["ace_captives_isSurrendering", false];
    ["ace_captives_setSurrendered", [_x, !_surrendering], _x] call CBA_fnc_targetEvent;
} forEach _units;
