#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates the load bar to reflect the current load of the inventory.
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

params ["_display"];

private _currentLoad = _display getVariable QGVAR(currentLoad);
private _maximumLoad = _display getVariable QGVAR(maximumLoad);
private _loadPercent = 0 max _currentLoad / _maximumLoad min 1;

private _ctrlLoad = _display displayCtrl IDC_LOAD;
_ctrlLoad progressSetPosition _loadPercent;
_ctrlLoad ctrlSetTooltip format [localize "STR_3DEN_percentageUnit", _loadPercent * 100 toFixed 1, "%"];
