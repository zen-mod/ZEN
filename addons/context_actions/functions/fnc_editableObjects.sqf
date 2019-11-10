#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates editable objects for the local curator based on the given mode and radius.
 *
 * Arguments:
 * 0: Mode (Add/Remove) <BOOL>
 * 1: Radius <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [true, 100] call zen_context_actions_fnc_editableObjects
 *
 * Public: No
 */

params ["_mode", "_radius"];

private _curator = getAssignedCuratorLogic player;
private _objects = nearestObjects [ASLtoAGL _contextPosASL, ["All"], _radius, true];
private _eventName = [QEGVAR(common,removeObjects), QEGVAR(common,addObjects)] select _mode;

[_eventName, [_objects, _curator]] call CBA_fnc_serverEvent;
