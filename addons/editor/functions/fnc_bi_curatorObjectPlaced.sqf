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
 * True <BOOL>
 *
 * Example:
 * [curator, object] call BIS_fnc_curatorObjectPlaced
 *
 * Public: No
 */
#include "script_component.hpp"

params ["", "_object"];

_object call BIS_fnc_curatorAttachObject;

private _group = group _object;

if (GVAR(unitRadioMessages) == 0 && {!isNull _group && {side _group in [west, east, independent, civilian]}}) then {
    [effectiveCommander _object, "CuratorObjectPlaced"] call BIS_fnc_curatorSayMessage;
};

BIS_fnc_curatorObjectPlaced_mouseOver = curatorMouseOver;

private _curatorInfoType = getText (configFile >> "CfgVehicles" >> typeOf _object >> "curatorInfoType");

if (getNumber (configFile >> _curatorInfoType >> "filterAttributes") == 0) then {
    _object call BIS_fnc_showCuratorAttributes;
};

true
