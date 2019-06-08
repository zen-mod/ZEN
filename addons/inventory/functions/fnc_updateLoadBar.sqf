/*
 * Author: mharis001
 * Updates the load bar to reflect the current load in the inventory.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_updateLoadBar
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display"];

private _maxLoad = _display getVariable QGVAR(maxLoad);
private _currentLoad = _display getVariable QGVAR(currentLoad);
private _loadPercent = 0 max _currentLoad / _maxLoad min 1;

private _ctrlLoad = _display displayCtrl IDC_LOAD;
_ctrlLoad progressSetPosition _loadPercent;
_ctrlLoad ctrlSetTooltip format ["%1%2", _loadPercent * 100 toFixed 1, "%"];
