/*
 * Author: mharis001
 * Handles clicking the animations or textures tab buttons.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_garage_fnc_onTabSelect
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_ctrlButton"];

private _display = ctrlParent _ctrlButton;
private _ctrlIDC = ctrlIDC _ctrlButton;

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlSetFade 0;
    _ctrl ctrlCommit FADE_DELAY;
} forEach [IDC_LIST_BACKGROUND, IDC_LIST_FRAME];

{
    private _active = _ctrlIDC == _x;
    private _fade = [1, 0] select _active;
    private _fadeTime = [0, FADE_DELAY] select _active;

    private _ctrlBackground = _display displayCtrl (_x - 1);
    _ctrlBackground ctrlSetFade _fade;
    _ctrlBackground ctrlCommit FADE_DELAY;

    private _ctrlButton = _display displayCtrl _x;
    _ctrlButton ctrlEnable !_active;

    private _ctrlList = _display displayCtrl (_x + 1);
    _ctrlList ctrlEnable _active;
    _ctrlList ctrlSetFade _fade;
    _ctrlList ctrlCommit _fadeTime;

    if (_active) then {
        private _ctrlEmpty = _display displayCtrl IDC_LIST_EMPTY;
        _ctrlEmpty ctrlSetFade (lbSize _ctrlList min 1);
        _ctrlEmpty ctrlCommit FADE_DELAY;
    };
} forEach [IDC_BUTTON_ANIMATIONS, IDC_BUTTON_TEXTURES];
