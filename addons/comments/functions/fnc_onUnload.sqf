#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles unloading the Zeus Display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_comments_fnc_onUnload
 *
 * Public: No
 */


if (GVAR(movingComment) isNotEqualTo []) then {
    // Zeus displayed closed before moving stopped
    // Reset comment back to original position
    GVAR(movingComment) call FUNC(moveComment);
    GVAR(movingComment) = [];
};
