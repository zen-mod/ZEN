#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates a comment in Zeus locally.
 *
 * Arguments:
 * 0: Unique comment id <STRING>
 * 1: Comment position ASL <ARRAY>
 * 2: Comment title <STRING>
 * 3: Comment tooltip <STRING>
 * 4: Name of the curator that created the comment <STRING>
 *
 * Return Value:
 * None.
 *
 * Example:
 * ["zeus:1", [0,0,0], "My Comment", "This is a nice comment", "Joe"] call zen_comments_fnc_createCommentLocal
 *
 * Public: No
 */

if (!hasInterface) exitWith {};

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
if (!isNull _display) then {
    [_display, _this] call FUNC(createIcon);
};

GVAR(comments) pushBack _this;
