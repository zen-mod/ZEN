#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles drawing the comments in Zeus 3D.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call zen_comments_fnc_onDraw3D
 *
 * Public: No
 */

BEGIN_COUNTER(onDraw3D);

if (!GVAR(enableComments) && !GVAR(enable3DENComments)) exitWith {
    removeMissionEventHandler [_thisEvent, _thisEventHandler];

    {ctrlDelete _y} forEach GVAR(icons);
    GVAR(icons) = createHashMap;

    GVAR(draw3DAdded) = false;
    LOG("Removed Draw3D.");
};

if (
    isNull (findDisplay IDD_RSCDISPLAYCURATOR) ||   // We are in not Zeus
    {!isNull (findDisplay IDD_INTERRUPT)} ||        // Pause menu is opened
    {call EFUNC(common,isInScreenshotMode)}         // HUD is hidden
) exitWith {
    {_y ctrlShow false} forEach GVAR(icons);
};

{
    _x params ["_draw", "_comments", "_color", "_activeColor"];

    if (_draw && _comments isNotEqualTo []) then {
        [_comments, GVAR(icons), _color, _activeColor] call FUNC(drawComments);
    } else {
        [_comments, GVAR(icons), false] call FUNC(showIcons);
    };
} forEach [
    [GVAR(enableComments), GVAR(comments), GVAR(commentColor), GVAR(commentsActiveColor)],
    [GVAR(enable3DENComments), GVAR(3DENComments), GVAR(3DENCommentColor), GVAR(3DENCommentsActiveColor)]
];

END_COUNTER(onDraw3D);
