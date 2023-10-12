#include "script_component.hpp"

if (isServer) then {
    [QGVAR(set), LINKFUNC(set)] call CBA_fnc_addEventHandler;

    addMissionEventHandler ["MarkerDeleted", {
        params ["_marker"];

    // Filter all non-ZEN markers
    if !(QUOTE(ADDON) in _marker) exitWith {};

        [_marker] call CBA_fnc_removeGlobalEventJIP;
        [(_marker splitString "_" select -1) call BIS_fnc_objectFromNetId, false] call FUNC(set);
    }];
};

if (hasInterface) then {
    EGVAR(area_markers,blacklist) pushBack QUOTE(ADDON);

    [QEGVAR(placement,done), {
        params ["_object"];

        [nil, _object] call FUNC(handleObjectPlaced);
    }] call CBA_fnc_addEventHandler;
};
