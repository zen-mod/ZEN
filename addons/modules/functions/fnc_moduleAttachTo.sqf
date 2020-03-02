#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to attach an object to another.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleAttachTo
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NoObjectSelected)] call EFUNC(common,showMessage);
};

// Detach object if currently attached
if (!isNull attachedTo _object) exitWith {
    detach _object;

    [LSTRING(ObjectDetached)] call EFUNC(common,showMessage);
};

// Get object to attach to
[_object, {
    params ["_successful", "_object"];

    if (!_successful) exitWith {};

    curatorMouseOver params ["_type", "_entity"];
    if (_type != "OBJECT") exitWith {};

    if (_object == _entity) exitWith {
        [LSTRING(CannotAttachToSelf)] call EFUNC(common,showMessage);
    };

    private _direction = getDir _object - getDir _entity;

    _object attachTo [_entity];
    [QEGVAR(common,setDir), [_object, _direction], _object] call CBA_fnc_targetEvent;

    [LSTRING(ObjectAttached)] call EFUNC(common,showMessage);
}, [], LSTRING(ModuleAttachTo)] call EFUNC(common,selectPosition);
