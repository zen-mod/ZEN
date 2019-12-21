#include "script_component.hpp"

if (isServer) then {
    [QGVAR(spawn), {call EFUNC(common,deserializeObjects)}] call CBA_fnc_addEventHandler;
};

["ZEN_displayCuratorLoad", LINKFUNC(initDisplayCurator)] call CBA_fnc_addEventHandler;
[QEGVAR(editor,modeChanged), LINKFUNC(handleTreeChange)] call CBA_fnc_addEventHandler;
[QEGVAR(editor,sideChanged), LINKFUNC(handleTreeChange)] call CBA_fnc_addEventHandler;
