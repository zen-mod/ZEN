#include "script_component.hpp"
/*
 * Author: Ampersand
 * Handles the behaviour of the curatorMoveCamTo user action.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Key handled <BOOLEAN>
 *
 * Example:
 * [] call zen_editor_fnc_handleCuratorMoveCamTo
 *
 * Public: No
 */

private _selectedObjects = SELECTED_OBJECTS;
if (count _selectedObjects == 0) exitWith {false};

private _selectedObject = _selectedObjects select 0;
private _objectPos = getPosWorld _selectedObject;
private _objectDir = getDir _selectedObject;
((0 boundingBoxReal _selectedObject) select 1) params ["", "_y", "_z"];
private _minDistance = 20;

// Toggle between far and close views on subsequent activations with the same object selected
if (isNil QGVAR(curatorMovedCamTo) || {_selectedObject != GVAR(curatorMovedCamTo)}) then {
    GVAR(curatorMovedCamTo) = _selectedObject;
} else {
    _minDistance = 0.5;
    GVAR(curatorMovedCamTo) = nil;
};

private _curatorPos = _objectPos getPos [_minDistance max _y, _objectDir + 180];
_curatorPos set [2, (_objectPos select 2) + (_minDistance max _z)];
curatorCamera setPosASL _curatorPos;
curatorCamera setDir _objectDir;
curatorCamera setVectorUp (vectorDir curatorCamera vectorAdd [0, 0, 1 + 1 / _minDistance]);

true
