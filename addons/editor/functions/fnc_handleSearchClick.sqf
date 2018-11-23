/*
 * Author: mharis001
 * Handles mouse button click event for custom search bar.
 *
 * Arguments:
 * 0: Search box <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * Return Name <TYPE>
 *
 * Example:
 * [CONTROL, 1] call zen_editor_fnc_handleSearchClick
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_ctrlSearchCustom", "_button"];

// Only clear when right clicking
if (_button != 1) exitWith {};

private _display = ctrlParent _ctrlSearchCustom;
private _ctrlSearchEngine = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
_ctrlSearchEngine ctrlSetText "";

_ctrlSearchCustom ctrlSetText "";
ctrlSetFocus _ctrlSearchCustom;
