#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles unloading the Zeus display.
 *
 * Arguments:
 * 0: Display (not used) <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_comments_fnc_handleUnload
 *
 * Public: No
 */

// Stop dragging (restores the comment's original position)
[] call FUNC(stopDragging);

// The icon controls are deleted along with the display
GVAR(icons) = createHashMap;
GVAR(hoveredComment) = "";

if (!isNil QGVAR(draw3D)) then {
    removeMissionEventHandler ["Draw3D", GVAR(draw3D)];
    GVAR(draw3D) = nil;
};
