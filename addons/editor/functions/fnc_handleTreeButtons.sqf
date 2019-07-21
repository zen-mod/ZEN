#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the tree collapse and expand all buttons.
 *
 * Arguments:
 * 0: Expand <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [false] call zen_editor_fnc_handleTreeButtons
 *
 * Public: No
 */

params ["_expand"];

// Can't collapse or expand marker or recent trees
if (RscDisplayCurator_sections select 0 > 2) exitWith {};

// Collapse or expand current tree
private _ctrlTree = call EFUNC(common,getActiveTree);

if (_expand) then {
    tvExpandAll _ctrlTree;
} else {
    _ctrlTree call EFUNC(common,collapseTree);
};
