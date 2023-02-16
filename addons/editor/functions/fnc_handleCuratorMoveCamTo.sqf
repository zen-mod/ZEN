#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handles the behaviour of the curatorMoveCamTo user action.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_editor_fnc_handleCuratorMoveCamTo
 *
 * Public: No
 */

private _selectedObjects = SELECTED_OBJECTS;
if (count _selectedObjects == 0) exitWith {};

private _selectedObject = _selectedObjects select 0;
if (isNil QGVAR(curatorMovedCamTo) || {_selectedObject != GVAR(curatorMovedCamTo)}) exitWith {
    GVAR(curatorMovedCamTo) = _selectedObject;
};

// Second activation of curatorMoveCamTo on same object
// Move camera to top-rear of object bounding box for CQB view
(0 boundingBoxReal GVAR(curatorMovedCamTo)) params ["_p1", "_p2"];
curatorCamera setPosASL (GVAR(curatorMovedCamTo) modelToWorldVisualWorld [0, _p1 select 1, _p2 select 2]);
curatorCamera setDir getDir GVAR(curatorMovedCamTo);
GVAR(curatorMovedCamTo) = nil;
