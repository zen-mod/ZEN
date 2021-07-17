#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles placement of an object by Zeus.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Placed Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _object] call zen_editor_fnc_handleObjectPlaced
 *
 * Public: No
 */

params ["", "_object"];

// Re-collapse the entities tree if editable icons are hidden
// Placing an object expands a portion of the tree
if (!GVAR(iconsVisible)) then {
    private _ctrlEntites = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_ENTITIES;
    _ctrlEntites call EFUNC(common,collapseTree);
};

RscDisplayCurator_sections params ["_mode"];

if (!GVAR(includeCrew) && {_mode == 0 || {_mode == 4 && {isClass (configFile >> "CfgVehicles" >> GVAR(recentTreeData))}}}) then {
    deleteVehicleCrew _object;
};
