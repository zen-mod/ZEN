#include "script_component.hpp"

if (!hasInterface) exitWith {};

["zen_curatorDisplayLoaded", LINKFUNC(handleCuratorLoad)] call CBA_fnc_addEventHandler;

// TODO: when CBA updates this will not need the helper display as code can be executed directly
// Also, a condition to only show the option to curators can be added
[
    [LLSTRING(Features), LLSTRING(Features_Description)],
    QGVAR(pauseMenuHelper)
] call CBA_fnc_addPauseMenuOption;
