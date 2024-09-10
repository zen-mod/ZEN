#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles key up event for custom search bar.
 *
 * Arguments:
 * 0: Search box <CONTROL>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [CONTROL] call zen_editor_fnc_handleSearchKeyUp
 *
 * Public: No
 */

params ["_ctrlSearchCustom"];

// Auto clear search when search bar is empty
if (ctrlText _ctrlSearchCustom == "") then {
    private _display = ctrlParent _ctrlSearchCustom;
    private _ctrlSearchEngine = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
    _ctrlSearchEngine ctrlSetText "";
};

false
