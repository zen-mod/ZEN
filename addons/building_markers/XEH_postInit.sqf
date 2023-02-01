#include "script_component.hpp"

if (isServer) then {
    [QGVAR(setBuildingMarker), LINKFUNC(setBuildingMarker)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    EGVAR(area_markers,blacklist) pushBack QUOTE(ADDON);
    [QEGVAR(placement,done), {
        if (GVAR(enabled)) then {
            [QGVAR(setBuildingMarker), [_this, true]] call CBA_fnc_serverEvent;
        };
    }] call CBA_fnc_addEventHandler;
};
