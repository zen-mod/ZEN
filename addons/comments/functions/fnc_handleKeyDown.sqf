#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles pressing a key down in the Zeus display.
 *
 * Arguments:
 * 0: Display (not used) <DISPLAY>
 * 1: Key Code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [DISPLAY, 0] call zen_comments_fnc_handleKeyDown
 *
 * Public: No
 */

params ["", "_key"];

// Delete the hovered comment when the delete key is pressed
if (
    _key == DIK_DELETE
    && {GVAR(hoveredComment) != ""}
    && {!GETMVAR(RscDisplayCurator_search,false)}
    && {
        GVAR(allowDeleting3DEN) || {
            private _is3DENComment = GVAR(hoveredComment) call FUNC(is3DENComment);
            !_is3DENComment
        }
    }
) exitWith {
    [GVAR(hoveredComment)] call FUNC(deleteComment);
    true // handled
};

false
