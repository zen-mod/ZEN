/*
 * Author: Bohemia Interactive, mharis001, Kex
 * Handles placement of an object by Zeus.
 * Edited to allow control over radio messages, not automatically
 * showing inventory attributes for ammo box objects and activating
 * copy/pasted modules.
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

if (_object isKindOf "Module_f") then
{
	_object setVariable ["BIS_fnc_initModules_activate", true, true];
};

BIS_fnc_curatorObjectPlaced_mouseOver = curatorMouseOver;

private _curatorInfoType = getText (configFile >> "CfgVehicles" >> typeOf _object >> "curatorInfoType");

if (getNumber (configFile >> _curatorInfoType >> "filterAttributes") == 0 && {!(_object isKindOf "ReammoBox_F")}) then {
    _object call BIS_fnc_showCuratorAttributes;
};

true
