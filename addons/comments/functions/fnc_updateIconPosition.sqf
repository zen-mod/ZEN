#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates the positioning of the given icon control.
 *
 * Arguments:
 * 0: Icon <CONTROL>
 * 1: Screen Position <ARRAY>
 * 2: Scale <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, [0.5, 0.5], 1] call zen_comments_fnc_updateIconPosition
 *
 * Public: No
 */

params ["_ctrlIcon", "_screenPos", "_scale"];

private _id = _ctrlIcon getVariable QGVAR(id);
private _data = GVAR(comments) get _id;
_data params ["", "_title", "", "", "_creator"];

private _imageW = POS_W(ICON_SIZE * _scale);
private _imageH = POS_H(ICON_SIZE * _scale);

// The child controls are laid out based on the scale and the texts
// They only need to be repositioned when those change
private _previousLayoutState = _ctrlIcon getVariable [QGVAR(layoutState), []];
private _layoutState = [_scale, _title, _creator];

if (_layoutState isNotEqualTo _previousLayoutState) then {
    private _ctrlTitle = _ctrlIcon controlsGroupCtrl IDC_ICON_TITLE;
    private _ctrlImage = _ctrlIcon controlsGroupCtrl IDC_ICON_IMAGE;
    private _ctrlCreator = _ctrlIcon controlsGroupCtrl IDC_ICON_CREATOR;

    private _textH = POS_H(ICON_TEXT_HEIGHT * _scale);
    private _maxTextW = POS_W(ICON_TEXT_MAX_WIDTH * _scale);

    // Sets the given text on the control, cut short with an ellipsis to fit, and returns its width
    private _fnc_fitText = {
        params ["_ctrlText", "_text"];

        _ctrlText ctrlSetFontHeight _textH;
        _ctrlText ctrlSetText _text;

        // Find the longest start of the text that fits by halving the searched range of lengths
        if (ctrlTextWidth _ctrlText > _maxTextW) then {
            private _fits = 0;
            private _cut = count _text;

            while {_cut - _fits > 1} do {
                private _length = floor ((_fits + _cut) / 2);
                _ctrlText ctrlSetText format ["%1...", _text select [0, _length]];

                if (ctrlTextWidth _ctrlText > _maxTextW) then {
                    _cut = _length;
                } else {
                    _fits = _length;
                };
            };

            _ctrlText ctrlSetText format ["%1...", _text select [0, _fits]];
        };

        ctrlTextWidth _ctrlText
    };

    private _titleW = [_ctrlTitle, _title] call _fnc_fitText;
    private _titleH = [0, _textH] select (_title != "");
    private _creatorW = [_ctrlCreator, _creator] call _fnc_fitText;
    private _creatorH = [0, _textH] select (_creator != "");
    private _groupW = selectMax [_titleW, _imageW, _creatorW];
    private _groupH = _titleH + _imageH + _creatorH;

    {
        _x params ["_ctrl", "_ctrlY", "_ctrlW", "_ctrlH"];

        _ctrl ctrlSetPosition [(_groupW - _ctrlW) / 2, _ctrlY, _ctrlW, _ctrlH];
        _ctrl ctrlCommit 0;
    } forEach [
        [_ctrlTitle, 0, _titleW, _titleH],
        [_ctrlImage, _titleH, _imageW, _imageH],
        [_ctrlCreator, _titleH + _imageH, _creatorW, _creatorH]
    ];

    _ctrlIcon setVariable [QGVAR(layoutState), _layoutState];
    _ctrlIcon setVariable [QGVAR(layoutDimensions), [_groupW, _groupH, _titleH]];
};

private _layoutDimensions = _ctrlIcon getVariable QGVAR(layoutDimensions);
_layoutDimensions params ["_groupW", "_groupH", "_titleH"];
_screenPos params ["_screenPosX", "_screenPosY"];

// Subtracting safe zones since the icon is in the container controls group
private _groupX = _screenPosX - _groupW / 2 - safeZoneXAbs;
private _groupY = _screenPosY - _imageH / 2 - _titleH - safeZoneY;
_ctrlIcon ctrlSetPosition [_groupX, _groupY, _groupW, _groupH];
_ctrlIcon ctrlCommit 0;
