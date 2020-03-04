#include "script_component.hpp"

["zen_curatorDisplayLoaded", {
    {
        if (GVAR(state)) then {
            [true] call FUNC(toggle);
        };
    } call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

["zen_curatorDisplayUnloaded", {
    [false] call FUNC(toggle);
}] call CBA_fnc_addEventHandler;
