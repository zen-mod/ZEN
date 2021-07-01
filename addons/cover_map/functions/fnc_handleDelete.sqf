#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles pressing the delete button.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_cover_map_fnc_handleDelete
 *
 * Public: No
 */

params ["_ctrlDelete"];

private _display = ctrlParent _ctrlDelete;
private _ctrlMap = _display displayCtrl IDC_CM_MAP;
_ctrlMap setVariable [QGVAR(area), nil];
