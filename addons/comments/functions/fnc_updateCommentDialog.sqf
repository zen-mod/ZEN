#include "script_component.hpp"
/*
 * Author: Timi007
 * Opens the dialog for editing a comment.
 *
 * Arguments:
 * 0: Unique comment id <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:2"] call zen_comments_fnc_updateCommentDialog
 *
 * Public: No
 */

params ["_id"];

if !(_id in GVAR(comments)) exitWith {};
(GVAR(comments) get _id) params ["_posASL", "_title", ["_tooltip", "", [""]], ["_color", DEFAULT_COLOR, [[]], [4]]];

[
    localize STR_CREATE_COMMENT,
    [
        ["EDIT", localize "str_3den_comment_attribute_name_displayname", [_title], true],
        ["EDIT:MULTI", localize "str_3den_comment_attribute_name_tooltip", [_tooltip], true],
        ["COLOR", localize "str_3den_marker_attribute_color_displayname", _color, true]
    ],
    {
        (_this select 0) params ["_title", "_tooltip", "_color"];
        (_this select 1) params ["_id", "_posASL"];

        [QGVAR(updateComment), [_id, _posASL, _title, _tooltip, _color, profileName]] call CBA_fnc_serverEvent;
    },
    {},
    [_id, _posASL]
] call EFUNC(dialog,create);
