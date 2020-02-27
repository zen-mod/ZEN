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

RscDisplayCurator_sections params ["_mode"];

// Can't collapse or expand marker or recent trees
if (_mode > 2) exitWith {};

// Collapse or expand current tree
private _ctrlTree = call EFUNC(common,getActiveTree);

if (_expand) then {
    tvExpandAll _ctrlTree;
} else {
    _ctrlTree call EFUNC(common,collapseTree);

    // For QOL, keep factions of group trees visible
    if (_mode == 1) then {
        _ctrlTree tvExpand [0];
    };
};
