#include "script_component.hpp"

if (isServer) then {
    [QGVAR(createMarker), LINKFUNC(createMarker)] call CBA_fnc_addEventHandler;
};

if (hasInterface) then {
    ["zen_curatorDisplayLoaded", LINKFUNC(initDisplayCurator)] call CBA_fnc_addEventHandler;

    // Add EHs to update visibility of area marker icons when the map is toggled
    // Need both activate and deactivate to deal with issues around rapidly toggling the map
    addUserActionEventHandler ["showMap", "Activate", {call FUNC(onMapToggled)}];
    addUserActionEventHandler ["showMap", "Deactivate", {call FUNC(onMapToggled)}];

    // Add EHs to automatically make any area markers editable
    addMissionEventHandler ["MarkerCreated", {call FUNC(onMarkerCreated)}];
    addMissionEventHandler ["MarkerDeleted", {call FUNC(onMarkerDeleted)}];
    addMissionEventHandler ["MarkerUpdated", {call FUNC(onMarkerUpdated)}];
};
