#include "script_component.hpp"

if (is3DEN) exitWith {};

if (isServer) then {
    GVAR(nextId) = 0;
    [QGVAR(createComment), LINKFUNC(createComment)] call CBA_fnc_addEventHandler;
    [QGVAR(deleteComment), LINKFUNC(deleteComment)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    [QGVAR(createCommentLocal), LINKFUNC(createCommentLocal)] call CBA_fnc_addEventHandler;
    [QGVAR(deleteCommentLocal), LINKFUNC(deleteCommentLocal)] call CBA_fnc_addEventHandler;

    ["zen_curatorDisplayLoaded", LINKFUNC(addDrawEventHandler)] call CBA_fnc_addEventHandler;

    GVAR(3DENComments) = getMissionConfigValue [QGVAR(3DENComments), []];
    TRACE_1("Loaded 3DEN Comments from mission",GVAR(3DENComments));
};
