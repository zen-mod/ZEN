#include "script_component.hpp"

["ZEN_displayCuratorLoad", {
    {
        if (GVAR(state)) then {
            [true] call FUNC(toggle);
        };
    } call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

["ZEN_displayCuratorUnload", {
    [false] call FUNC(toggle);
}] call CBA_fnc_addEventHandler;
