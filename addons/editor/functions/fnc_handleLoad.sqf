#include "script_component.hpp"
#include "\a3\ui_f\hpp\defineResinclDesign.inc" // can't put this in config due to undef error
/*
 * Author: mharis001
 * Handles initializing the Zeus Display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_editor_fnc_handleLoad
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
} else {
    private _ctrlSearchEngine = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_SEARCH;
    _ctrlSearchEngine ctrlAddEventHandler ["MouseButtonClick", {
        params ["_ctrlSearchEngine", "_button"];

        if (_button == 1) then {
            _ctrlSearchEngine ctrlSetText "";
            ctrlSetFocus _ctrlSearchEngine;
        };
    }];
};

_display displayAddEventHandler ["KeyDown", {call FUNC(handleKeyDown)}];

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["ButtonClick", {call FUNC(handleModeButtons)}];
} forEach IDCS_MODE_BUTTONS;

// Need events to check if side buttons are hovered since changing the mode
// also triggers the button click event for the side buttons
{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["ButtonClick", {call FUNC(handleSideButtons)}];

    _ctrl ctrlAddEventHandler ["MouseEnter", {
        params ["_ctrl"];
        _ctrl setVariable [QGVAR(hovered), true];
    }];

    _ctrl ctrlAddEventHandler ["MouseExit", {
        params ["_ctrl"];
        _ctrl setVariable [QGVAR(hovered), false];
    }];
} forEach IDCS_SIDE_BUTTONS;

// Fix selecting a path in group trees preventing selecting an editable icon using left click
// This matches the behaviour of other trees by deselecting any non-placement path when selecting an editable icon
{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["MouseButtonDown", {
        if (RscDisplayCurator_sections select 0 == 1) then {
            private _ctrlTree = call EFUNC(common,getActiveTree);
            private _pathLength = count tvCurSel _ctrlTree;

            if (_pathLength > 0 && {_pathLength < 4}) then {
                _ctrlTree tvSetCurSel [-1];
            };
        };
    }];
} forEach [
    IDC_RSCDISPLAYCURATOR_MOUSEAREA,
    IDC_RSCDISPLAYCURATOR_MAINMAP
];

// Add tree selection changed events
private _ctrlTreeModule = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;
_ctrlTreeModule ctrlAddEventHandler ["TreeSelChanged", {
    params ["_ctrlTreeModule", "_selectedPath"];

    [QGVAR(ModuleSelChanged), _ctrlTreeModule tvData _selectedPath] call CBA_fnc_localEvent;
}];

private _ctrlTreeRecent = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_RECENT;
_ctrlTreeRecent ctrlAddEventHandler ["TreeSelChanged", {
    params ["_ctrlTreeRecent", "_selectedPath"];
    private _recentTreeData = _ctrlTreeRecent tvData _selectedPath;

    // Store data of selected item to allow for deleting the of crew of objects placed through the recent tree
    // tvCurSel is unavailable once the selected item has been placed, the empty string check ensures that the
    // data is not cleared since this event occurs before the object placed event
    if !(_recentTreeData isEqualTo "") then {
        GVAR(recentTreeData) = _recentTreeData;
    };

    if (_recentTreeData isKindOf "Module_F") then {
        [QGVAR(ModuleSelChanged), _recentTreeData] call CBA_fnc_localEvent;
    } else {
        [QGVAR(ModuleSelChanged), ""] call CBA_fnc_localEvent;
    };
}];

// Initially open the map fully zoomed out and centered
if (isNil QGVAR(previousMapState)) then {
    GVAR(previousMapState) = [1, [worldSize / 2, worldSize / 2]];
};

// Restore previous map state from when display was closed
GVAR(previousMapState) params ["_mapScale", "_mapPosition"];

private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
_ctrlMap ctrlMapAnimAdd [0, _mapScale, _mapPosition];
ctrlMapAnimCommit _ctrlMap;

// Reset editable icons visibility tracking variable
// Prevents unwanted behaviour if display is closed while icons are hidden
GVAR(iconsVisible) = true;

[{
    // For compatibility with Zeus Game Master missions, wait until the respawn placement phase is complete
    [{
        params ["_display"];

        isNull _display || {entities "ModuleMPTypeGameMaster_F" isEqualTo []} || {GETMVAR(BIS_moduleMPTypeGameMaster_init,false)}
    }, {
        params ["_display"];

        if (isNull _display) exitWith {};

        [_display] call FUNC(addGroupIcons);
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
    }, _this] call CBA_fnc_waitUntilAndExecute;
}, _display] call CBA_fnc_execNextFrame;
