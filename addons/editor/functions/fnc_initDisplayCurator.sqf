#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineResinclDesign.inc" // can't put this in config due to undef error
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
 * [DISPLAY] call zen_editor_fnc_initDisplayCurator
 *
 * Public: No
 */

params ["_display"];

if (GVAR(removeWatermark)) then {
    private _ctrlWatermark = _display displayCtrl IDC_RSCDISPLAYCURATOR_WATERMARK;
    _ctrlWatermark ctrlSetText "";
};

if (GVAR(disableLiveSearch)) then {
    private _ctrlGroupAdd = _display displayCtrl IDC_RSCDISPLAYCURATOR_ADD;

    private _ctrlSearchEngine = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
    private _searchBarPos = ctrlPosition _ctrlSearchEngine;
    _ctrlSearchEngine ctrlEnable false;
    _ctrlSearchEngine ctrlShow false;

    private _ctrlSearchCustom = _display ctrlCreate ["RscEdit", IDC_SEARCH_CUSTOM, _ctrlGroupAdd];
    _ctrlSearchCustom ctrlSetPosition _searchBarPos;
    _ctrlSearchCustom ctrlCommit 0;

    _ctrlSearchCustom ctrlAddEventHandler ["MouseButtonClick", {call FUNC(handleSearchClick)}];
    _ctrlSearchCustom ctrlAddEventHandler ["KeyDown", {call FUNC(handleSearchKeyDown)}];
    _ctrlSearchCustom ctrlAddEventHandler ["KeyUp", {call FUNC(handleSearchKeyUp)}];
    _ctrlSearchCustom ctrlAddEventHandler ["SetFocus", {RscDisplayCurator_search = true}];
    _ctrlSearchCustom ctrlAddEventHandler ["KillFocus", {RscDisplayCurator_search = false}];

    private _ctrlSearchButton = _display displayCtrl IDC_SEARCH_BUTTON;
    _ctrlSearchButton ctrlAddEventHandler ["ButtonClick", {call FUNC(handleSearchButton)}];
};

_display displayAddEventHandler ["KeyDown", {call FUNC(handleKeyDown)}];

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["ButtonClick", {call FUNC(handleModeButtons)}];
} forEach IDCS_MODE_BUTTONS;

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["ButtonClick", {call FUNC(handleSideButtons)}];
    _ctrl ctrlAddEventHandler ["MouseEnter", {UNLOCK}];
    _ctrl ctrlAddEventHandler ["MouseExit", {LOCK}];
} forEach IDCS_SIDE_BUTTONS;

private _ctrlTreeRecent = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_RECENT;
_ctrlTreeRecent ctrlAddEventHandler ["TreeSelChanged", {
    params ["_ctrlTreeRecent", "_selectedPath"];

    // Store data of selected item to allow for deleting the of crew of objects placed through the recent tree
    // tvCurSel is unavailable once the selected item has been placed, the empty path check ensures that the
    // data is not cleared since this event occurs before the object placed event
    if !(_selectedPath isEqualTo []) then {
        GVAR(recentTreeData) = _ctrlTreeRecent tvData _selectedPath;
    };
}];

[{
    params ["_display"];

    [_display] call FUNC(declutterEmptyTree);

    {
        private _ctrl = _display displayCtrl _x;
        _ctrl call EFUNC(common,collapseTree);
    } forEach IDCS_UNIT_TREES;

    {
        private _ctrl = _display displayCtrl _x;
        _ctrl call EFUNC(common,collapseTree);
        _ctrl tvExpand [0]; // Expand side level path so all factions are visible
    } forEach IDCS_GROUP_TREES;
}, _display] call CBA_fnc_execNextFrame;
