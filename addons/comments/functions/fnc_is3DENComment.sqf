#include "script_component.hpp"
/*
 * Author: Timi007
 * Checks if the comment with the given ID is a 3DEN comment.
 *
 * Arguments:
 * 0: Comment ID <STRING>
 *
 * Return Value:
 * Is 3DEN Comment <BOOL>
 *
 * Example:
 * ["3den:0"] call zen_comments_fnc_is3DENComment
 *
 * Public: No
 */

params ["_id"];

_id select [0, COMMENT_TYPE_PREFIX_LENGTH] == COMMENT_TYPE_3DEN
