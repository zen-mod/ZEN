#include "script_component.hpp"

if (!hasInterface) exitWith {};

["zen_curatorDisplayLoaded", LINKFUNC(handleCuratorLoad)] call CBA_fnc_addEventHandler;

[
    [LLSTRING(Features), LLSTRING(Features_Description)],
    LINKFUNC(handlePauseMenuOption),
    {!isNull curatorCamera}
] call CBA_fnc_addPauseMenuOption;
