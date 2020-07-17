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
 * [] call BIS_fnc_showCuratorAttributesForSelection
 *
 * Public: No
 */

curatorSelected params ["_objects", "_groups", "_waypoints", "_markers"];

private _entity = switch (true) do {
    case !(_groups isEqualTo []): {_groups select 0};
    case !(_objects isEqualTo []): {_objects select 0};
    case !(_markers isEqualTo []): {_markers select 0};
    case !(_waypoints isEqualTo []): {_waypoints select 0};
    default { nil };
};

if !(isNil "_entity") then {
    _entity call BIS_fnc_showCuratorAttributes;
};
