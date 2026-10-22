#include "script_component.hpp"

if (isServer) then {
    [QGVAR(createComment), LINKFUNC(createComment)] call CBA_fnc_addEventHandler;
    [QGVAR(deleteComment), LINKFUNC(deleteComment)] call CBA_fnc_addEventHandler;
    [QGVAR(updateComment), LINKFUNC(updateComment)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    ["zen_curatorDisplayLoaded", LINKFUNC(handleLoad)] call CBA_fnc_addEventHandler;
    ["zen_curatorDisplayUnloaded", LINKFUNC(handleUnload)] call CBA_fnc_addEventHandler;
    ["CBA_SettingChanged", LINKFUNC(handleSettingChanged)] call CBA_fnc_addEventHandler;
};

// Comments are stored on every machine, the server needs them to update and delete them
[QGVAR(commentCreated), LINKFUNC(handleCommentCreated)] call CBA_fnc_addEventHandler;
[QGVAR(commentDeleted), LINKFUNC(handleCommentDeleted)] call CBA_fnc_addEventHandler;
[QGVAR(commentUpdated), LINKFUNC(handleCommentUpdated)] call CBA_fnc_addEventHandler;

{
    _x params ["_id", "_data"];
    _data params ["_position", "_title", "_tooltip"];

    // 3DEN comments have no creator and a locked position
    // and their color comes from the setting
    GVAR(comments) set [_id, [_position, _title, _tooltip, [], "", true]];
} forEach getMissionConfigValue [QGVAR(3DENComments), []];

TRACE_1("Loaded 3DEN comments from mission",GVAR(comments));
