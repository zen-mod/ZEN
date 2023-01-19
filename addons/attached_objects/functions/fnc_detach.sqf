#include "script_component.hpp"
/*
 * Author: mharis001
 * Detaches the given objects (excluding vehicle cargo) from their parent object.
 *
 * Arguments:
 * N: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call zen_attached_objects_fnc_detach
 *
 * Public: No
 */

private _count = 0;

{
    if (!isNull attachedTo _x && {isNull isVehicleCargo _x}) then {
        detach _x;
        _count = _count + 1;
    };
} forEach _this;

[LSTRING(ObjectsDetached), _count] call EFUNC(common,showMessage);
