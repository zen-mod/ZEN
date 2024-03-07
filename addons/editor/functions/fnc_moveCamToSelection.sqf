#include "script_component.hpp"
/*
 * Author: Ampersand
 * Moves the curator camera to the selected object.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_editor_fnc_moveCamToSelection
 *
 * Public: No
 */

#define FOCUS_ALT 1
#define FOCUS_CQB 2
#define FOCUS_ALTCQB 3

private _selectedObjects = SELECTED_OBJECTS;
if (count _selectedObjects == 0) exitWith {};

private _selectedObject = _selectedObjects select 0;
private _objectPos = getPosWorld _selectedObject;
private _objectDir = getDir _selectedObject;
((0 boundingBoxReal _selectedObject) select 1) params ["", "_y", "_z"];

private _minDistance = switch (GVAR(moveCamToSelection)) do {
    case (FOCUS_ALT): {
        20
    };
    case (FOCUS_CQB): {
        0.5
    };
    case (FOCUS_ALTCQB): {
        // Toggle between far and close views on subsequent activations with the same object selected
        if (isNil QGVAR(curatorMovedCamTo) || {_selectedObject != GVAR(curatorMovedCamTo)}) then {
            GVAR(curatorMovedCamTo) = _selectedObject;
            20
        } else {
            GVAR(curatorMovedCamTo) = nil;
            0.5
        }
    };
};

private _curatorPos = _objectPos getPos [_minDistance max _y, _objectDir + 180];
_curatorPos set [2, (_objectPos select 2) + (_minDistance max _z)];
curatorCamera setPosASL _curatorPos;
curatorCamera setDir _objectDir;
curatorCamera setVectorUp (vectorDir curatorCamera vectorAdd [0, 0, 1 + 1 / _minDistance]);
