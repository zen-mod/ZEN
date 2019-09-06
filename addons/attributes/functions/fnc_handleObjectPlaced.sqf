#include "script_component.hpp"
/*
 * Author: mharis001
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
 * [_logic, _object] call zen_attributes_fnc_handleObjectPlaced
 *
 * Public: No
 */

params ["", "_object"];

_object call BIS_fnc_curatorAttachObject;

BIS_fnc_curatorObjectPlaced_mouseOver = curatorMouseOver;

private _infoTypeClass = if (isNull group _object && {side _object != sideLogic}) then {"curatorInfoTypeEmpty"} else {"curatorInfoType"};
private _infoType = getText (configfile >> "CfgVehicles" >> typeOf _object >> _infoTypeClass);

if (isClass (configFile >> _infoType) && {getNumber (configFile >> _infoType >> "filterAttributes") == 0}) then {
    _object call BIS_fnc_showCuratorAttributes;
};
