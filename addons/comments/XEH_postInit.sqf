#include "script_component.hpp"

if (isServer) then {
    [QGVAR(createComment), LINKFUNC(createComment)] call CBA_fnc_addEventHandler;
    [QGVAR(deleteComment), LINKFUNC(deleteComment)] call CBA_fnc_addEventHandler;
    [QGVAR(updateComment), LINKFUNC(updateComment)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    GVAR(comments) = createHashMapFromArray getMissionConfigValue [QGVAR(3DENComments), []];
    TRACE_1("Loaded 3DEN Comments from mission",GVAR(comments));

    [QGVAR(commentCreated), LINKFUNC(onCommentCreated)] call CBA_fnc_addEventHandler;
    [QGVAR(commentDeleted), LINKFUNC(onCommentDeleted)] call CBA_fnc_addEventHandler;
    [QGVAR(commentUpdated), LINKFUNC(onCommentUpdated)] call CBA_fnc_addEventHandler;

    ["zen_curatorDisplayLoaded", LINKFUNC(addDrawEventHandler)] call CBA_fnc_addEventHandler;
    ["zen_curatorDisplayUnloaded", LINKFUNC(onUnload)] call CBA_fnc_addEventHandler;
};
