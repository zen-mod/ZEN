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
#include "script_component.hpp"

params ["_logic"];

if (!local _logic) exitWith {};

private _object = attachedTo _logic;
deleteVehicle _logic;

if (isNull _object) exitWith {
    [LSTRING(NothingSelected)] call EFUNC(common,showMessage);
};

// Detach object if currently attached
private _attached = _object getVariable [QGVAR(attached), objNull];

if (!isNull _attached) exitWith {
    detach _object;
    _object setVariable [QGVAR(attached), nil];

    [LSTRING(ObjectDetached)] call EFUNC(common,showMessage);
};

// Get object to attach to
[_object, {
    params ["_successful", "_object"];

    curatorMouseOver params ["_type", "_entity"];
    if (_type != "OBJECT") exitWith {};

    if (_object == _entity) exitWith {
        [LSTRING(CannotAttachToSelf)] call EFUNC(common,showMessage);
    };

    private _direction = getDir _object - getDir _entity;

    _object attachTo [_entity];
    _object setVariable [QGVAR(attached), _entity];
    [QEGVAR(common,setDir), [_object, _direction], _object] call CBA_fnc_targetEvent;

    [LSTRING(ObjectAttached)] call EFUNC(common,showMessage);
}, localize LSTRING(ModuleAttachTo)] call EFUNC(common,getModuleTarget);
