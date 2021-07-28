#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates elements of the inventory display such as the list buttons,
 * the weapon specific items button, and the load bar.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Only Update Buttons <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_update
 *
 * Public: No
 */

params ["_display", ["_onlyButtons", false]];

// Get the currently selected item and its mass
private _ctrlList = _display displayCtrl IDC_LIST;
private _currentRow = lnbCurSelRow _ctrlList;
private _item = _ctrlList lnbData [_currentRow, 0];
private _mass = _item call FUNC(getItemMass);

// Get the current and maximum load for the object
private _currentLoad = _display getVariable QGVAR(currentLoad);
private _maximumLoad = _display getVariable QGVAR(maximumLoad);

// Enable add button if object has enough space for the item
private _ctrlButtonAdd = _display displayCtrl IDC_BTN_ADD;
_ctrlButtonAdd ctrlEnable (_maximumLoad - _currentLoad >= _mass);

// Enable remove button if item count is not zero
private _ctrlButtonRemove = _display displayCtrl IDC_BTN_REMOVE;
_ctrlButtonRemove ctrlEnable (_ctrlList lnbValue [_currentRow, 2] > 0);

// Enable weapon specific items button if in all items mode and selected item is a weapon
private _ctrlButtonWeapon = _display displayCtrl IDC_BTN_WEAPON;
_ctrlButtonWeapon ctrlEnable (_display getVariable [QGVAR(weapon), ""] == "" && {_item call EFUNC(common,isWeapon)});

if (_onlyButtons) exitWith {};

// Update the load bar's position and tooltip to reflect the current load
private _loadPercent = 0 max _currentLoad / _maximumLoad min 1;

private _ctrlLoadBar = _display displayCtrl IDC_LOAD_BAR;
_ctrlLoadBar progressSetPosition _loadPercent;

_ctrlLoadBar ctrlSetTooltip format [
    "%1 / %2 (%3)",
    [_currentLoad, 1, 0, true] call CBA_fnc_formatNumber,
    [_maximumLoad, 1, 0, true] call CBA_fnc_formatNumber,
    format [localize "STR_3DEN_percentageUnit", _loadPercent * 100 toFixed 1, "%"]
];
