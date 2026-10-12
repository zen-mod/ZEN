#include "script_component.hpp"
/*
 * Author: mharis001
 * Renders a section of a feature's page, with an optional heading.
 * Sections show their text and list, either as a callout or alongside their media.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Position <ARRAY>
 *   - The height is determined by the content.
 * 2: Section <CONFIG>
 *
 * Return Value:
 * Section <CONTROL>
 *
 * Example:
 * [CONTROL, [0, 0, 1], _section] call zen_tour_fnc_renderSection
 *
 * Public: No
 */

params ["_controlsGroup", "_position", "_section"];
_position params ["_posX", "_posY", "_posW"];

private _ctrlSection = ctrlParent _controlsGroup ctrlCreate ["RscControlsGroupNoScrollbars", -1, _controlsGroup];
_ctrlSection ctrlSetPosition [_posX, _posY, _posW, 0];
_ctrlSection ctrlCommit 0;

// Returns the bottom edge of the given control
private _fnc_getBottom = {
    ctrlPosition _this params ["", "_posY", "", "_height"];
    _posY + _height
};

private _title = getText (_section >> "title");
private _style = getText (_section >> "style");
private _layout = getText (_section >> "layout");
private _hasMedia = ["picture", "comparison", "slides"] findIf {!isNull (_section >> _x)} != -1;
private _hasBody = ["text", "items"] findIf {!isNull (_section >> _x)} != -1;
private _contentY = 0;

// Headings are separated from the previous section by a divider
if (_title != "") then {
    [_ctrlSection, [0, 0, _posW, pixelH], [1, 1, 1, 0.1]] call FUNC(createBox);

    private _headingPosition = [0, POS_H(SECTION_HEADING_Y), _posW, POS_H(SECTION_HEADING_HEIGHT)];
    [_ctrlSection, QGVAR(heading), _headingPosition, _title] call FUNC(createText);

    _contentY = POS_H(SECTION_CONTENT_Y);
};

private _height = switch (true) do {
    // Callouts are inset into a tinted box, with an accent bar and label in the color of their style
    case (_style in ["note", "tip", "warning"]): {
        private _styleParams = switch (_style) do {
            case "note": {
                [LLSTRING(Note), [0.27, 0.58, 0.97, 1]]
            };
            case "tip": {
                [LLSTRING(Tip), [0.25, 0.73, 0.31, 1]]
            };
            case "warning": {
                [LLSTRING(Warning), [0.82, 0.6, 0.13, 1]]
            };
        };

        _styleParams params ["_label", "_color"];

        private _accentW = POS_W(CALLOUT_ACCENT_WIDTH);
        private _ctrlBackground = [_ctrlSection, [0, _contentY, _posW, 0], [1, 1, 1, 0.05]] call FUNC(createBox);
        private _ctrlAccent = [_ctrlSection, [0, _contentY, _accentW, 0], _color] call FUNC(createBox);

        private _innerX = _accentW + POS_W(CALLOUT_PADDING);
        private _innerY = _contentY + POS_H(CALLOUT_PADDING);
        private _innerW = _posW - _innerX - POS_W(CALLOUT_PADDING);

        private _labelPosition = [_innerX, _innerY, _innerW, POS_H(CALLOUT_LABEL_HEIGHT)];
        private _ctrlLabel = [_ctrlSection, QGVAR(label), _labelPosition, _label] call FUNC(createText);
        _ctrlLabel ctrlSetTextColor _color;

        private _bodyY = _innerY + POS_H(CALLOUT_BODY_Y);
        private _ctrlBody = [_ctrlSection, [_innerX, _bodyY, _innerW], _section] call FUNC(renderBody);
        private _bottom = (_ctrlBody call _fnc_getBottom) + POS_H(CALLOUT_PADDING);

        {
            _x ctrlSetPositionH (_bottom - _contentY);
            _x ctrlCommit 0;
        } forEach [_ctrlBackground, _ctrlAccent];

        _bottom
    };
    // Media beside the text, which share the width of the section
    case (_hasMedia && {_layout in ["left", "right"]}): {
        private _mediaW = _posW * SECTION_SIDE_MEDIA_RATIO;
        private _bodyW = _posW - _mediaW - POS_W(SECTION_COLUMN_SPACING);

        private _isLeft = _layout == "left";
        private _mediaX = [_bodyW + POS_W(SECTION_COLUMN_SPACING), 0] select _isLeft;
        private _bodyX = [0, _mediaW + POS_W(SECTION_COLUMN_SPACING)] select _isLeft;

        private _ctrlMedia = [_ctrlSection, [_mediaX, _contentY, _mediaW], _section] call FUNC(renderMedia);
        private _ctrlBody = [_ctrlSection, [_bodyX, _contentY, _bodyW], _section] call FUNC(renderBody);

        (_ctrlMedia call _fnc_getBottom) max (_ctrlBody call _fnc_getBottom)
    };
    // Media above the text, with both taking the full width
    default {
        if (_hasMedia) then {
            private _ctrlMedia = [_ctrlSection, [0, _contentY, _posW], _section] call FUNC(renderMedia);
            _contentY = _ctrlMedia call _fnc_getBottom;

            if (_hasBody) then {
                _contentY = _contentY + POS_H(SECTION_MEDIA_SPACING);
            };
        };

        if (_hasBody) then {
            private _ctrlBody = [_ctrlSection, [0, _contentY, _posW], _section] call FUNC(renderBody);
            _contentY = _ctrlBody call _fnc_getBottom;
        };

        _contentY
    };
};

_ctrlSection ctrlSetPositionH _height;
_ctrlSection ctrlCommit 0;
_ctrlSection
