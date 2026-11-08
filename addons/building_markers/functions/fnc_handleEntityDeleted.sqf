#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handles an entity being deleted.
 *
 * Arguments:
 * 0: Entity <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [OBJECT] call zen_building_markers_fnc_handleEntityDeleted
 *
 * Public: No
 */

params ["_entity"];

private _marker = _entity getVariable [QGVAR(marker), ""];

if (_marker != "") then {
    deleteMarker _marker;
};
