#include "script_component.hpp"

["zen_curatorDisplayLoaded", LINKFUNC(handleLoad)] call CBA_fnc_addEventHandler;
["zen_curatorDisplayUnloaded", LINKFUNC(handleUnload)] call CBA_fnc_addEventHandler;
[QGVAR(modeChanged), LINKFUNC(fixSideButtons)] call CBA_fnc_addEventHandler;
addUserActionEventHandler ["curatorMoveCamTo", "Deactivate", LINKFUNC(handleCuratorMoveCamTo)];
