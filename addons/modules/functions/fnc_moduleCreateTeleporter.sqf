#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create a teleporter.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleCreateTeleporter
 *
 * Public: No
 */

params ["_logic"];

private _object = attachedTo _logic;
private _position = getPosATL _logic;

[LSTRING(ModuleCreateTeleporter), [
    ["EDIT", "STR_3DEN_Object_Attribute_UnitName_displayName", _position call BIS_fnc_locationDescription, true]
], {
    params ["_values", "_args"];
    _values params ["_name"];
    _args params ["_object", "_position"];

    [QGVAR(moduleCreateTeleporter), [_object, _position, _name]] call CBA_fnc_serverEvent;
}, {}, [_object, _position]] call EFUNC(dialog,create);

deleteVehicle _logic;
