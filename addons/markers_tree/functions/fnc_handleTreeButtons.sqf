#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the tree collapse and expand all buttons.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Expand <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, false] call zen_markers_tree_fnc_handleTreeButtons
 *
 * Public: No
 */

params ["_display", "_expand"];

// Only handle the custom icon markers tree, rest are handled by editor component
if (RscDisplayCurator_sections select 0 != 3 || {GVAR(mode) != 0}) exitWith {};

private _ctrlTreeIcons = _display displayCtrl IDC_MARKERS_TREE_ICONS;

if (_expand) then {
    tvExpandAll _ctrlTreeIcons;
} else {
    _ctrlTreeIcons call EFUNC(common,collapseTree);
};
