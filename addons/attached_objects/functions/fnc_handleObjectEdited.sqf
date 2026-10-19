#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles editing of an object by Zeus.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Edited Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _object] call zen_attached_objects_fnc_handleObjectEdited
 *
 * Public: No
 */

params ["", "_object"];

// Update the position of attached objects relative to their parent object
private _parentObject = attachedTo _object;

if (!isNull _parentObject && {isVehicleCargo _object != _parentObject}) then {
    private _offset = _parentObject worldToModel ASLToAGL getPosWorld _object;
    private _dirAndUp = [vectorDir _object, vectorUp _object] apply {_parentObject vectorWorldToModel _x};

    // setVectorDirAndUp requires local argument but applying the rotation on a remote object
    // makes editing smoother for Zeus before the target event is processed by the remote machine
    _object setVectorDirAndUp _dirAndUp;
    _object attachTo [_parentObject, _offset];

    [QEGVAR(common,setVectorDirAndUp), [_object, _dirAndUp], _object] call CBA_fnc_targetEvent;
};
