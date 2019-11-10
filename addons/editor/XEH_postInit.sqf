#include "script_component.hpp"

["ZEN_displayCuratorLoad", LINKFUNC(handleLoad)] call CBA_fnc_addEventHandler;
["ZEN_displayCuratorUnload", LINKFUNC(handleUnload)] call CBA_fnc_addEventHandler;
[QGVAR(modeChanged), LINKFUNC(fixSideButtons)] call CBA_fnc_addEventHandler;
