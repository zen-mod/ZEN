#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the search button.
 *
 * Arguments:
 * 0: Search button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_editor_fnc_handleSearchButton
 *
 * Public: No
 */

params ["_ctrlSearchButton"];

// Confirm search when button is clicked
private _display = ctrlParent _ctrlSearchButton;
private _ctrlSearchEngine = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
private _ctrlSearchCustom = _display displayCtrl IDC_SEARCH_CUSTOM;

_ctrlSearchEngine ctrlSetText ctrlText _ctrlSearchCustom;
