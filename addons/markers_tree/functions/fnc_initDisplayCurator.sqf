#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the Zeus Display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_markers_tree_fnc_initDisplayCurator
 *
 * Public: No
 */

params ["_display"];

private _ctrlTreeEngine = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MARKERS;
_ctrlTreeEngine ctrlAddEventHandler ["TreeSelChanged", {call FUNC(handleEngineSelect)}];

private _ctrlTreeCustom = _display displayCtrl IDC_MARKERS_TREE;
_ctrlTreeCustom ctrlAddEventHandler ["TreeSelChanged", {call FUNC(handleCustomSelect)}];
_ctrlTreeCustom call FUNC(populate);

// Handle initially hiding/showing the custom markers tree
private _sections = missionNamespace getVariable ["RscDisplayCurator_sections", [0, 0]];
_ctrlTreeCustom ctrlShow (_sections select 0 == 3);

private _ctrlCollapseAll = _display displayCtrl IDC_COLLAPSE_ALL;
_ctrlCollapseAll ctrlAddEventHandler ["ButtonClick", {false call FUNC(handleTreeButtons)}];

private _ctrlExpandAll = _display displayCtrl IDC_EXPAND_ALL;
_ctrlExpandAll ctrlAddEventHandler ["ButtonClick", {true call FUNC(handleTreeButtons)}];

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["ButtonClick", {call FUNC(handleModeChange)}];
} forEach IDCS_MODE_BUTTONS;

_display displayAddEventHandler ["KeyDown", {call FUNC(handleKeyDown)}];
