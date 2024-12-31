#include "script_component.hpp"

if (isServer) then {
    [QGVAR(createComment), LINKFUNC(createComment)] call CBA_fnc_addEventHandler;
    [QGVAR(deleteComment), LINKFUNC(deleteComment)] call CBA_fnc_addEventHandler;
    [QGVAR(updateComment), LINKFUNC(updateComment)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    {
        _x params ["_id", "_position", "_title", "_tooltip"];

        // Comments from 3DEN do not have the creator's name
        GVAR(comments) set [_id, [_position, _title, _tooltip, ""]];
    } forEach getMissionConfigValue [QGVAR(3DENComments), []];

    [QGVAR(commentCreated), LINKFUNC(onCommentCreated)] call CBA_fnc_addEventHandler;
    [QGVAR(commentDeleted), LINKFUNC(onCommentDeleted)] call CBA_fnc_addEventHandler;
    [QGVAR(commentUpdated), LINKFUNC(onCommentUpdated)] call CBA_fnc_addEventHandler;

    // ["zen_curatorDisplayLoaded", LINKFUNC(addDrawEventHandler)] call CBA_fnc_addEventHandler;
};
