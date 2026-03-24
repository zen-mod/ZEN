#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens the "Update Editable Objects" module dialog at the given position.
 *
 * Arguments:
 * 0: Position <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_position] call zen_context_actions_fnc_openEditableObjectsDialog
 *
 * Public: No
 */

params ["_position"];

private _logic = QEGVAR(modules,moduleEditableObjects) createVehicleLocal [0, 0, 0];
_logic setPosASL _position;
_logic call BIS_fnc_showCuratorAttributes;
