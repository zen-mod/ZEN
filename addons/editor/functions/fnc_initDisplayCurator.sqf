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
    _ctrlSearchCustom ctrlAddEventHandler ["SetFocus", {RscDisplayCurator_search = true}];
    _ctrlSearchCustom ctrlAddEventHandler ["KillFocus", {RscDisplayCurator_search = false}];

    private _ctrlSearchButton = _display displayCtrl IDC_SEARCH_BUTTON;
    _ctrlSearchButton ctrlAddEventHandler ["ButtonClick", {call FUNC(handleSearchButton)}];
};

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["ButtonClick", {
        [{
            params ["_ctrl"];

            private _display = ctrlParent _ctrl;
            RscDisplayCurator_sections params ["_mode"];

            private _idcs = switch (_mode) do {
                case 0;
                case 1: {IDCS_SIDE_BUTTONS};
                case 2;
                case 3: {[IDC_RSCDISPLAYCURATOR_SIDEEMPTY]};
                default {[]}
            };

            {
                (_display displayCtrl _x) ctrlShow true;
            } forEach _idcs;
        }, _this] call CBA_fnc_execNextFrame;
    }];
} forEach IDCS_MODE_BUTTONS;
