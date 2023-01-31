#include "script_component.hpp"

if (isServer) then {
    [QGVAR(setBuildingMarker), LINKFUNC(setBuildingMarker)] call CBA_fnc_addEventHandler;
};
