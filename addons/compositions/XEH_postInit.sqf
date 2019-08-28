#include "script_component.hpp"

if (isServer) then {
    [QGVAR(spawn), LINKFUNC(spawn)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    ["ZEN_displayCuratorLoad", LINKFUNC(initDisplayCurator)] call CBA_fnc_addEventHandler;
    [QEGVAR(editor,modeChanged), LINKFUNC(handleTreeChange)] call CBA_fnc_addEventHandler;
    [QEGVAR(editor,sideChanged), LINKFUNC(handleTreeChange)] call CBA_fnc_addEventHandler;
};
