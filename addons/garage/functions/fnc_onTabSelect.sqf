#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the animations or textures tab buttons.
 *
 * Arguments:
 * 0: Selected Tab <NUMBER>
 * 1: Forced <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_garage_fnc_onTabSelect
 *
 * Public: No
 */

params ["_selectedTab", ["_forced", false]];

if (!_forced && {_selectedTab == GVAR(currentTab)}) then {
    _selectedTab = -1;
};

private _display = findDisplay IDD_DISPLAY;

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlSetFade parseNumber (_selectedTab == -1);
    _ctrl ctrlCommit 0;
} forEach [IDC_LIST_BACKGROUND, IDC_LIST_FRAME];

private _ctrlEmpty = _display displayCtrl IDC_LIST_EMPTY;
_ctrlEmpty ctrlSetFade 1;
_ctrlEmpty ctrlCommit 0;

{
    private _active = _selectedTab == _forEachIndex;
    private _fade = parseNumber !_active;
    private _fadeTime = [0, FADE_DELAY] select (_active && {!_forced});

    private _ctrlBackground = _display displayCtrl (_x - 1);
    _ctrlBackground ctrlSetFade _fade;
    _ctrlBackground ctrlCommit _fadeTime;

    private _ctrlList = _display displayCtrl (_x + 1);
    _ctrlList ctrlEnable _active;
    _ctrlList ctrlSetFade _fade;
    _ctrlList ctrlCommit _fadeTime;

    if (_active) then {
        _ctrlEmpty ctrlSetFade (lbSize _ctrlList min 1);
        _ctrlEmpty ctrlCommit _fadeTime;
    };
} forEach [IDC_BUTTON_ANIMATIONS, IDC_BUTTON_TEXTURES];

GVAR(currentTab) = _selectedTab;
