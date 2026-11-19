#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles the mouse events for a comparison control to enable dragging the divider.
 *
 * Arguments:
 * 0: Mouse Area <CONTROL>
 * 1: Dragging <BOOL> (default: nil)
 *   - Starts or stops dragging when given.
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, true] call zen_tour_fnc_handleComparisonDrag
 *
 * Public: No
 */

params ["_ctrlMouse", "_isDragging"];

if (!isNil "_isDragging") then {
    _ctrlMouse setVariable [QGVAR(dragging), _isDragging];
};

if !(_ctrlMouse getVariable [QGVAR(dragging), false]) exitWith {};

// Stop the comparison's animation from moving the divider away from the mouse
private _ctrlComparison = ctrlParentControlsGroup _ctrlMouse;
_ctrlComparison setVariable [QGVAR(state), MEDIA_STATE_MANUAL];

// The divider follows the mouse, split at its position across the comparison
private _mouseX = ctrlMousePosition _ctrlMouse select 0;
private _mouseW = ctrlPosition _ctrlMouse select 2;
private _split = 0 max _mouseX / _mouseW min 1;
[_ctrlComparison, _split] call FUNC(setComparisonSplit);
