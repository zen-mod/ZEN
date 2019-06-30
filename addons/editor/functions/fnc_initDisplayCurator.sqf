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
#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineResinclDesign.inc" // can't put this in config due to undef error

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

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["ButtonClick", {call FUNC(fixSideButtons)}];
} forEach IDCS_MODE_BUTTONS;

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
    
    curatorCamera camCommand "maxPitch 89";
}, _display] call CBA_fnc_execNextFrame;
