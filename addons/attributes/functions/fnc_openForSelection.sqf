#include "script_component.hpp"
/*
 * Author: Ampersand
 * Opens the attributes display for the selected entity.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_attributes_fnc_openForSelection
 *
 * Public: No
 */

curatorSelected params ["_objects", "_groups", "_waypoints", "_markers"];

switch (true) do {
    case !(_groups isEqualTo []): {[_groups select 0, "Group"] call zen_attributes_fnc_open};
    case !(_objects isEqualTo []): {[_objects select 0, "Object"] call zen_attributes_fnc_open};
    case !(_markers isEqualTo []): {[_markers select 0, "Marker"] call zen_attributes_fnc_open};
    case !(_waypoints isEqualTo []): {[_waypoints select 0, "Waypoint"] call zen_attributes_fnc_open};
};

true
