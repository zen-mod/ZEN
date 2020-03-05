#include "script_component.hpp"

["zen_curatorDisplayLoaded", LINKFUNC(initDisplayCurator)] call CBA_fnc_addEventHandler;
[QEGVAR(editor,modeChanged), LINKFUNC(handleTreeChange)] call CBA_fnc_addEventHandler;
[QEGVAR(editor,sideChanged), LINKFUNC(handleTreeChange)] call CBA_fnc_addEventHandler;
