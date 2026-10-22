#include "script_component.hpp"
/*
 * Author: Timi007
 * Deletes the icon control of the given comment.
 *
 * Arguments:
 * 0: Comment ID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0"] call zen_comments_fnc_deleteIcon
 *
 * Public: No
 */

params ["_id"];

if !(_id in GVAR(icons)) exitWith {};

// Stop dragging or hovering the comment
if (GVAR(draggedComment) == _id) then {
    [] call FUNC(stopDragging);
};

if (GVAR(hoveredComment) == _id) then {
    GVAR(hoveredComment) = "";
};

// Delete the icon (needs to be done after stopping any dragging)
ctrlDelete (GVAR(icons) deleteAt _id);

// Stop the rendering loop if there are no other icons (i.e., this was the last one)
if (GVAR(icons) isEqualTo createHashMap) then {
    removeMissionEventHandler ["Draw3D", GVAR(draw3D)];
    GVAR(draw3D) = nil;

    // The mouse control needs to be updated one final time since the rendering loop no longer does it
    [""] call FUNC(updateMouse);
};
