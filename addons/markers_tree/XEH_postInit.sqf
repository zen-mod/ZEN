#include "script_component.hpp"

["zen_curatorDisplayLoaded", LINKFUNC(initDisplayCurator)] call CBA_fnc_addEventHandler;
[QEGVAR(editor,modeChanged), LINKFUNC(handleModeChange)] call CBA_fnc_addEventHandler;
