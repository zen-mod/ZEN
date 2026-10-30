#include "script_component.hpp"

["zen_curatorDisplayLoaded", LINKFUNC(handleLoad)] call CBA_fnc_addEventHandler;
["zen_curatorDisplayUnloaded", LINKFUNC(handleUnload)] call CBA_fnc_addEventHandler;
["CBA_SettingChanged", LINKFUNC(handleSettingChanged)] call CBA_fnc_addEventHandler;
[missionNamespace, "OnGameOptionsExited", LINKFUNC(handleGameOptionsExited)] call BIS_fnc_addScriptedEventHandler;
