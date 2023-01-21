#include "script_component.hpp"
/*
 * Author: Brett, mharis001
 * Handles placement of an object by Zeus.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Placed Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _object] call zen_placement_fnc_handleObjectPlaced
 *
 * Public: No
 */

// Exit if placement preview is disabled or objects were placed using the map
if (!GVAR(enabled) || {visibleMap}) exitWith {};

params ["", "_object"];

// Ensure the placed object is the same type as the preview
// Prevents issues when placing modules
if (typeOf _object != typeOf GVAR(object)) exitWith {};

// Initially move the object away and disable damage
_object setPosASL [-1000, -1000, 1000];
_object allowDamage false;

// Apply the preview object's position to the placed object after a frame
// Helps in preventing the object from being destroyed by being moved
[{
    params ["_object", "_position", "_dirAndUp"];

    _object setPosASL _position;
    _object setVectorDirAndUp _dirAndUp;
    _object setVelocity [0, 0, 0];

    [{_this allowDamage true}, _object] call CBA_fnc_execNextFrame;
}, [_object, getPosASL GVAR(helper), [vectorDir GVAR(helper), vectorUp GVAR(helper)]]] call CBA_fnc_execNextFrame;

// Do not cancel the preview if the control key is held
if (cba_events_control) exitWith {};

[] call FUNC(setupPreview);
