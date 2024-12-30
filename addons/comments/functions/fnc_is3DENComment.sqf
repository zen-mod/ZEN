#include "script_component.hpp"
/*
 * Author: Timi007
 * Checks if comment with given id is an 3DEN comment.
 *
 * Arguments:
 * 0: Comment id <STRING>
 *
 * Return Value:
 * Is an 3DEN comment <BOOLEAN>
 *
 * Example:
 * ["3den:2"] call zen_comments_fnc_is3DENComment
 *
 * Public: No
 */

params ["_id"];

(_id splitString ":") params ["_type"];

_type isEqualTo COMMENT_TYPE_3DEN
