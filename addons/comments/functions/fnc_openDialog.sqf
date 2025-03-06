#include "script_component.hpp"
/*
 * Author: Timi007
 * Opens the dialog for creating a comment.
 *
 * Arguments:
 * 0: Position ASL <ARRAY> or Comment ID <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0]] call zen_comments_fnc_openDialog
 * ["zeus:0"] call zen_comments_fnc_openDialog
 *
 * Public: No
 */

params ["_positionOrId"];

private _id = ["", _positionOrId] select (_positionOrId isEqualType "");
private _isEditingComment = _id isNotEqualTo "";

(GVAR(comments) getOrDefault [_id, []]) params [
    ["_position", [], [[]], 3],
    ["_title", "", [""]],
    ["_tooltip", "", [""]],
    ["_color", DEFAULT_COLOR, [[]], 4],
    ["_creator", "", [""]],
    ["_lockPosition", false, [false]]
];

if (_positionOrId isEqualType [] && _position isEqualTo []) then {
    _position = _positionOrId;
};

[
    localize STR_CREATE_COMMENT,
    [
        ["EDIT", localize "str_3den_comment_attribute_name_displayname", [_title], true],
        ["EDIT:MULTI", localize "str_3den_comment_attribute_name_tooltip", [_tooltip], true],
        ["TOOLBOX:YESNO", LLSTRING(LockPosition), [_lockPosition], _isEditingComment],
        ["COLOR", localize "str_3den_marker_attribute_color_displayname", _color, _isEditingComment]
    ],
    {
        (_this select 0) params ["_title", "_tooltip", "_lockPosition", "_color"];
        (_this select 1) params ["_id", "_position"];

        if (_id isEqualTo "") then {
            [QGVAR(createComment), [_position, _title, _tooltip, _color, profileName, _lockPosition]] call CBA_fnc_serverEvent;
        } else {
            [QGVAR(updateComment), [_id, _position, _title, _tooltip, _color, profileName, _lockPosition]] call CBA_fnc_serverEvent;
        };
    },
    {},
    [_id, _position]
] call EFUNC(dialog,create);
