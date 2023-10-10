#include "script_component.hpp"
/*
 * Author: Ampersand
 * Attaches the child object to a selection on a parent object.
 *
 * Arguments:
 * 0: Child <OBJECT>
 * 1: Parent <OBJECT>
 * 2: Selection <STRING>
 * 3: Relative <BOOLEAN> True to maintain current relative orientation, false to match selection orientation
 *
 * Return Value:
 * None
 *
 * Example:
 * [_child] call zen_attached_objects_fnc_attachToSelection
 *
 * Public: No
 */

params ["_child", "_parent", "_selection", ["_isRelative", true]];

if (!isNull attachedTo _child) then {detach _child;};

private _childPos = _parent worldToModel ASLToAGL getPosWorldVisual _child;
private _childY = _parent vectorWorldToModelVisual vectorDirVisual _child;
private _childZ = _parent vectorWorldToModelVisual vectorUpVisual _child;
private _childX = _childY vectorCrossProduct _childZ;

private _selectionPos = _parent selectionPosition [_selection, LOD_MEMORY];
private _offset = _childPos vectorDiff _selectionPos;
_parent selectionVectorDirAndUp [_selection, LOD_MEMORY] params ["_selectionY", "_selectionZ"];
private _selectionX = _selectionY vectorCrossProduct _selectionZ;

private _m = matrixTranspose [_selectionX, _selectionY, _selectionZ];
private _pos = flatten ([_offset] matrixMultiply _m);
_child attachTo [_parent, _pos, _selection, true];

_child setVariable [QGVAR(attachedToSelection), _selection, true];

if (_isRelative) then {
    [_childX, _childY, _childZ] matrixMultiply _m params ["", "_vY", "_vZ"];
    _child setVectorDirAndUp [_vY, _vZ];
    [QEGVAR(common,setVectorDirAndUp), [_child, [_vY, _vZ]], _child] call CBA_fnc_targetEvent;
};
