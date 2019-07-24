#include "script_component.hpp"

["ZEN_displayCuratorLoad", {
    if (GVAR(enabled)) then {
        call FUNC(start);
    };
}] call CBA_fnc_addEventHandler;

["ZEN_displayCuratorUnload", {
    call FUNC(stop);
}] call CBA_fnc_addEventHandler;
