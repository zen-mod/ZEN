#include "script_component.hpp"
/*
 * Author: mharis001
 * Attaches the given objects to a parent object selected by Zeus.
 *
 * Arguments:
 * N: Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call zen_attached_objects_fnc_attach
 *
 * Public: No
 */

[_this, {
    params ["_successful", "_objects"];

    if (!_successful) exitWith {};

    curatorMouseOver params ["_type", "_entity"];
    if (_type != "OBJECT") exitWith {};

    // Prevent attaching object to itself
    private _index = _objects find _entity;

    if (_index != -1 && {count _objects == 1}) exitWith {
        [LSTRING(CannotAttachToSelf)] call EFUNC(common,showMessage);
    };

    _objects deleteAt _index;

    {
        _x attachTo [_entity];

        private _dirAndUp = [_entity vectorWorldToModel vectorDir _x, _entity vectorWorldToModel vectorUp _x];
        [QEGVAR(common,setVectorDirAndUp), [_x, _dirAndUp], _x] call CBA_fnc_targetEvent;
    } forEach _objects;

    [LSTRING(ObjectsAttached), count _objects] call EFUNC(common,showMessage);
}, [], LSTRING(AttachTo)] call EFUNC(common,selectPosition);
