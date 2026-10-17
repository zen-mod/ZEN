#include "script_component.hpp"
/*
 * Author: Timi007
 * Opens the dialog for creating or editing a comment.
 *
 * Arguments:
 * 0: Position ASL (create) or Comment ID (edit) <ARRAY|STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["zeus:0"] call zen_comments_fnc_openDialog
 *
 * Public: No
 */

params ["_positionOrID"];

private _id = ["", _positionOrID] select (_positionOrID isEqualType "");
private _data = GVAR(comments) getOrDefault [_id, []];
private _isEditing = _id != "";

_data params [
    ["_position", _positionOrID],
    ["_title", ""],
    ["_tooltip", ""],
    ["_color", GVAR(colorDefault)],
    "",
    ["_lockPosition", false]
];

private _dialogTitle = [
    "STR_3DEN_Display3DEN_EntityMenu_CreateComment_text",
    LSTRING(EditComment)
] select _isEditing;

[_dialogTitle, [
    [
        "EDIT",
        "STR_3DEN_Comment_Attribute_Name_displayName",
        _title,
        true
    ],
    [
        "EDIT:MULTI",
        "STR_3DEN_Comment_Attribute_Name_tooltip",
        _tooltip,
        true
    ],
    [
        "COLOR",
        "STR_3DEN_Marker_Attribute_Color_displayName",
        _color,
        true
    ],
    [
        "TOOLBOX:YESNO",
        [LSTRING(LockPosition), LSTRING(LockPosition_Description)],
        _lockPosition,
        true
    ]
], {
        params ["_values", "_args"];
        _values params ["_title", "_tooltip", "_color", "_lockPosition"];
        _args params ["_id", "_position"];

        if (_id == "") exitWith {
            [_position, _title, _tooltip, _color, profileName, _lockPosition] call FUNC(createComment);
        };

        // The comment may have been deleted while the dialog was open
        if !(_id in GVAR(comments)) exitWith {};

        // Only update the fields that are in the dialog
        // The comment could have moved while the dialog was open and the creator remains unchanged
        [_id, nil, _title, _tooltip, _color, nil, _lockPosition] call FUNC(updateComment);
}, {}, [_id, _position]] call EFUNC(dialog,create);
