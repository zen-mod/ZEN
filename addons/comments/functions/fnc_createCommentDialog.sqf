#include "script_component.hpp"
/*
 * Author: Timi007
 * Opens the dialog for creating a comment.
 *
 * Arguments:
 * 0: Comment position ASL <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0,0,0]] call zen_comments_fnc_createCommentDialog
 *
 * Public: No
 */

params ["_posASL"];

[
    localize STR_CREATE_COMMENT,
    [
        ["EDIT", localize "str_3den_comment_attribute_name_displayname", [""], true],
        ["EDIT:MULTI", localize "str_3den_comment_attribute_name_tooltip", [""], true],
        ["COLOR", localize "str_3den_marker_attribute_color_displayname", DEFAULT_COLOR]
    ],
    {
        params ["_values", "_posASL"];
        _values params ["_title", "_tooltip", "_color"];

        [QGVAR(createComment), [_posASL, _title, _tooltip, _color, profileName]] call CBA_fnc_serverEvent;
    },
    {},
    _posASL
] call EFUNC(dialog,create);
