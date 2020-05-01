#include "script_component.hpp"
/*
 * Author: NeilZar
 * Enables or disables the list buttons based on currently selected magazine.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_loadout_fnc_updateButtons
 *
 * Public: No
 */

params ["_display"];

// Get count of currently selected magazine
private _ctrlList = _display displayCtrl IDC_LIST;
private _count = _ctrlList lnbText [lnbCurSelRow _ctrlList, 2];

// Enable remove button if magazine count is not zero
private _ctrlButtonRemove = _display displayCtrl IDC_BTN_REMOVE;
_ctrlButtonRemove ctrlEnable (_count != "0");
