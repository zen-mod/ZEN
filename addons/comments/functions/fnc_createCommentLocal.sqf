#include "script_component.hpp"
/*
 * Author: Timi007
 * Creates the comment locally.
 *
 * Arguments:
 * 0: Unique comment id <STRING>
 * 1: Comment position ASL <ARRAY>
 * 2: Comment title <STRING>
 * 3: Comment tooltip <STRING>
 * 4: Comment color (RGBA) <ARRAY>
 * 5: Name of the curator that created the comment <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:1", [0,0,0], "My Comment", "This is a nice comment", [1,0,0,0.7], "Joe"] call zen_comments_fnc_createCommentLocal
 *
 * Public: No
 */

params ["_id"];

GVAR(comments) set [_id, _this select [1]];

// Will create icon and provides hook
[QGVAR(commentCreated), _this] call CBA_fnc_localEvent;
