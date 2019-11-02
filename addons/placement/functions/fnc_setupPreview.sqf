#include "script_component.hpp"
/*
 * Author: Brett, mharis001
 * Sets up the placement preview for the given object type.
 * Will delete current preview object if "" is provided.
 *
 * Arguments:
 * 0: Object Type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["B_Soldier_F"] call zen_placement_fnc_setupPreview
 *
 * Public: No
 */

params ["_objectType"];

// Exit if the given object type is the same as the current preview type
if (_objectType == typeOf GVAR(object)) exitWith {};

// Remove currently active preview
GVAR(updatePFH) call CBA_fnc_removePerFrameHandler;
deleteVehicle GVAR(object);
deleteVehicle GVAR(helper);

// Exit if creating a new preview object is not needed
if (_objectType == "") exitWith {};

// Create a helper to which the preview object will be attached
GVAR(helper) = "Logic" createVehicleLocal [0, 0, 0];
GVAR(helper) hideObject true;

// Create the preview object and attach it to the helper
GVAR(object) = _objectType createVehicleLocal [0, 0, 0];
GVAR(object) disableCollisionWith player;
GVAR(object) enableSimulation false;
GVAR(object) allowDamage false;

// Calculate the vertical offset as the difference between model center position
// and position transformed
private _offset = (getPosWorld GVAR(object) select 2) - (getPosASL GVAR(object) select 2);
GVAR(object) attachTo [GVAR(helper), [0, 0, _offset]];

// Prevent an editable icon from showing for the preview object
if (isServer) then {
    GVAR(object) setVariable [QEGVAR(common,autoAddObject), false];
};

// Add PFH to update preview
GVAR(updatePFH) = [LINKFUNC(updatePreview), 0, []] call CBA_fnc_addPerFrameHandler;
