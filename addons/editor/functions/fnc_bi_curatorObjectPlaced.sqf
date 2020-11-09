#include "script_component.hpp"
/*
 * Author: Bohemia Interactive, mharis001
 * Handles placement of an object by Zeus.
 * Edited to allow control over radio messages.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Placed Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _object] call BIS_fnc_curatorObjectPlaced
 *
 * Public: No
 */

params ["", "_object"];

_object call BIS_fnc_curatorAttachObject;
BIS_fnc_curatorObjectPlaced_mouseOver = curatorMouseOver;

private _infoTypeClass = ["curatorInfoType", "curatorInfoTypeEmpty"] select (isNull group _object && {side _object != sideLogic});
private _infoType = getText (configOf _object >> _infoTypeClass);

if (isClass (configFile >> _infoType) && {getNumber (configFile >> _infoType >> "filterAttributes") == 0}) then {
    _object call BIS_fnc_showCuratorAttributes;
};

private _group = group _object;

if (GVAR(unitRadioMessages) == 0 && {!isNull _group && {side _group in [west, east, independent, civilian]}}) then {
    [effectiveCommander _object, "CuratorObjectPlaced"] call BIS_fnc_curatorSayMessage;
};
