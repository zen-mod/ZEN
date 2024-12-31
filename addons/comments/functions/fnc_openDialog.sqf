#include "script_component.hpp"

params ["_comment"];

// todo: use same for new comment and editing an existing one

[
    localize STR_CREATE_COMMENT,
    [
        ["EDIT", localize "str_3den_comment_attribute_name_displayname", [""], true],
        ["EDIT:MULTI", localize "str_3den_comment_attribute_name_tooltip", [""], true]
    ],
    {
        params ["_values", "_posASL"];
        _values params ["_title", "_tooltip"];

        [QGVAR(createComment), [_posASL, _title, _tooltip, profileName]] call CBA_fnc_serverEvent;
    },
    {},
    _posASL
] call EFUNC(dialog,create);
