#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles drawing the comments on the Zeus map.
 *
 * Arguments:
 * 0: Zeus map <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_mapCtrl] call zen_comments_fnc_onDraw
 *
 * Public: No
 */

BEGIN_COUNTER(onDraw);

params ["_mapCtrl"];

if (!GVAR(enableComments) && !GVAR(enable3DENComments)) exitWith {
    _mapCtrl ctrlRemoveEventHandler [_thisEvent, _thisEventHandler];
    LOG("Removed 3DENComments map draw.");
};

// Draw is only called when map is open
if (call EFUNC(common,isInScreenshotMode)) exitWith {}; // HUD is hidden

{
    _x params ["_draw", "_comments", "_color", "_activeColor"];

    if (_draw && _comments isNotEqualTo []) then {
        [_comments, GVAR(icons), _color, _activeColor, _mapCtrl] call FUNC(drawComments);
    };
    // Icons are hidden in 3D first, so we don't need to hide them here again
} forEach [
    [GVAR(enableComments), GVAR(comments), GVAR(commentColor), GVAR(commentsActiveColor)],
    [GVAR(enable3DENComments), GVAR(3DENComments), GVAR(3DENCommentColor), GVAR(3DENCommentsActiveColor)]
];

END_COUNTER(onDraw);
