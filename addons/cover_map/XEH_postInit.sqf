#include "script_component.hpp"

if (isServer) then {
    [QGVAR(create), LINKFUNC(create)] call CBA_fnc_addEventHandler;
    [QGVAR(remove), LINKFUNC(remove)] call CBA_fnc_addEventHandler;
};
