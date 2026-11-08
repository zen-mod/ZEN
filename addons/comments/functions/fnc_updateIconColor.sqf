#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates the color of the given icon control.
 *
 * Arguments:
 * 0: Icon <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_comments_fnc_updateIconColor
 *
 * Public: No
 */

params ["_ctrlIcon"];

private _id = _ctrlIcon getVariable QGVAR(id);
private _color = GVAR(comments) get _id select DATA_INDEX_COLOR;

// 3DEN comments have no color of their own, the setting's color is used for them
if (_color isEqualTo []) then {
    _color = GVAR(color3DEN);
};

_color params ["_red", "_green", "_blue"];

// The dragged comment is highlighted like a hovered one
// It can lag behind the mouse so both tracking variables are checked
private _highlighted = _id in [GVAR(hoveredComment), GVAR(draggedComment)];
private _alpha = [ICON_ALPHA, ICON_ALPHA_HOVERED] select _highlighted;

// The color with alpha is stored on the icon for drawing its line to the surface
private _colorRGBA = [_red, _green, _blue, _alpha];
_ctrlIcon setVariable [QGVAR(color), _colorRGBA];

{
    private _ctrl = _ctrlIcon controlsGroupCtrl _x;
    _ctrl ctrlSetTextColor _colorRGBA;
} forEach [IDC_ICON_TITLE, IDC_ICON_IMAGE, IDC_ICON_CREATOR];
