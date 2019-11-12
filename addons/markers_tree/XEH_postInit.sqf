#include "script_component.hpp"

["ZEN_displayCuratorLoad", LINKFUNC(initDisplayCurator)] call CBA_fnc_addEventHandler;
[QEGVAR(editor,modeChanged), LINKFUNC(handleModeChange)] call CBA_fnc_addEventHandler;
