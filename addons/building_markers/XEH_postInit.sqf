#include "script_component.hpp"

if (isServer) then {
    [QGVAR(set), LINKFUNC(set)] call CBA_fnc_addEventHandler;

    addMissionEventHandler ["MarkerDeleted", {
        params ["_marker"];

        [_marker] call CBA_fnc_removeGlobalEventJIP;
        [missionNamespace getVariable [_marker, objNull], false] call FUNC(set);
        missionNamespace setVariable [_marker, nil];
    }];
};

if (hasInterface) then {
    EGVAR(area_markers,blacklist) pushBack QUOTE(ADDON);

    [QEGVAR(placement,done), {
        params ["_object"];

        [nil, _object] call FUNC(handleObjectPlaced);
    }] call CBA_fnc_addEventHandler;
};
