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
 * True <BOOL>
 *
 * Example:
 * [curator, object] call BIS_fnc_curatorObjectPlaced
 *
 * Public: No
 */

params ["", "_object"];

private _group = group _object;

if (GVAR(unitRadioMessages) == 0 && {!isNull _group && {side _group in [west, east, independent, civilian]}}) then {
    [effectiveCommander _object, "CuratorObjectPlaced"] call BIS_fnc_curatorSayMessage;
};

true
