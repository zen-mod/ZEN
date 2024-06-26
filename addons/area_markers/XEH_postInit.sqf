#include "script_component.hpp"

if (isServer) then {
    [QGVAR(createMarker), LINKFUNC(createMarker)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    ["zen_curatorDisplayLoaded", LINKFUNC(onLoad)] call CBA_fnc_addEventHandler;
    ["zen_curatorDisplayUnloaded", LINKFUNC(onUnload)] call CBA_fnc_addEventHandler;

    // Add EHs to automatically make any area markers editable
    addMissionEventHandler ["MarkerCreated", {call FUNC(onMarkerCreated)}];
    addMissionEventHandler ["MarkerDeleted", {call FUNC(onMarkerDeleted)}];
    addMissionEventHandler ["MarkerUpdated", {call FUNC(onMarkerUpdated)}];
};
