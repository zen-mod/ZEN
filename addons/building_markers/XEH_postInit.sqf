#include "script_component.hpp"

if (isServer) then {
    [QGVAR(set), LINKFUNC(set)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    EGVAR(area_markers,blacklist) pushBack QUOTE(ADDON);

    [QEGVAR(placement,done), {
        params ["_object"];

        [nil, _object] call FUNC(handleObjectPlaced);
    }] call CBA_fnc_addEventHandler;
};
