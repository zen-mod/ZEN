#include "script_component.hpp"
/*
 * Author: mharis001
 * Toggles the visibility of the user interface.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_garage_fnc_toggleInterface
 *
 * Public: No
 */

private _display = findDisplay IDD_DISPLAY;
private _visible = !GVAR(interfaceShown);

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlShow _visible;
} forEach [
    IDC_MENU_BAR,
    IDC_INFO_GROUP,
    IDC_BACKGROUND_ANIMATIONS,
    IDC_BUTTON_ANIMATIONS,
    IDC_BACKGROUND_TEXTURES,
    IDC_BUTTON_TEXTURES,
    IDC_LIST_BACKGROUND,
    IDC_LIST_FRAME,
    IDC_LIST_ANIMATIONS,
    IDC_LIST_TEXTURES,
    IDC_LIST_EMPTY
];

GVAR(interfaceShown) = _visible;
