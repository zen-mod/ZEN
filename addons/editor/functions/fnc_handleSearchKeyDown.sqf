#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles key down event for custom search bar.
 *
 * Arguments:
 * 0: Search box <CONTROL>
 * 1: Key code <NUMBER>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [CONTROL, 0] call zen_editor_fnc_handleSearchKeyDown
 *
 * Public: No
 */

params ["_ctrlSearchCustom", "_keyCode"];

// Confirm search on enter or numpad enter
if (_keyCode in [DIK_RETURN, DIK_NUMPADENTER]) exitWith {
    private _display = ctrlParent _ctrlSearchCustom;
    private _ctrlSearchEngine = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
    _ctrlSearchEngine ctrlSetText ctrlText _ctrlSearchCustom;

    true
};

false // Default to unhandled
