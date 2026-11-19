#include "script_component.hpp"
/*
 * Author: mharis001
 * Renders the text and list of a section.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Position <ARRAY>
 *   - The height is determined by the content.
 * 2: Section <CONFIG>
 *
 * Return Value:
 * Body <CONTROL>
 *
 * Example:
 * [CONTROL, [0, 0, 1], _section] call zen_tour_fnc_renderBody
 *
 * Public: No
 */

params ["_controlsGroup", "_position", "_section"];
_position params ["_posX", "_posY", "_posW"];

private _ctrlBody = ctrlParent _controlsGroup ctrlCreate ["RscControlsGroupNoScrollbars", -1, _controlsGroup];
_ctrlBody ctrlSetPosition [_posX, _posY, _posW, 0];
_ctrlBody ctrlCommit 0;

// Returns the height of the created text
private _fnc_createText = {
    params ["_posX", "_posY", "_posW", "_text"];

    private _ctrlText = [_ctrlBody, QGVAR(text), [_posX, _posY, _posW], _text] call FUNC(createText);
    ctrlPosition _ctrlText select 3
};

private _text = getText (_section >> "text");
private _isNumbered = getNumber (_section >> "numbered") == 1;
private _height = 0;
private _spacing = 0;
private _lineBottom = 0;

if (_text != "") then {
    _height = [0, 0, _posW, _text] call _fnc_createText;
    _spacing = POS_H(BODY_PARAGRAPH_SPACING);
};

{
    private _itemY = _height + _spacing;
    private _itemH = 0;

    if (_x isEqualType []) then {
        // Rows of a term (e.g. a shortcut) and its description, underlined halfway to the next row to read as a table
        _x params ["_term", "_description"];

        private _termW = POS_W(BODY_TERM_WIDTH);
        private _termH = [0, _itemY, _termW, _term] call _fnc_createText;
        private _descriptionH = [_termW, _itemY, _posW - _termW, _description] call _fnc_createText;
        _itemH = _termH max _descriptionH;

        private _lineY = _itemY + _itemH + POS_H(BODY_ITEM_SPACING) / 2;
        [_ctrlBody, [0, _lineY, _posW, pixelH], [1, 1, 1, 0.08]] call FUNC(createBox);
        _lineBottom = _lineY + pixelH;
    } else {
        // Text is indented past the marker so that wrapped lines stay aligned
        private _marker = if (_isNumbered) then {
            format ["<t font='RobotoCondensedBold' color='#ffffff'>%1.</t>", _forEachIndex + 1]
        } else {
            "<t color='#808080'>•</t>"
        };

        [0, _itemY, POS_W(BODY_MARKER_WIDTH), _marker] call _fnc_createText;
        _itemH = [POS_W(BODY_MARKER_WIDTH), _itemY, _posW - POS_W(BODY_MARKER_WIDTH), _x] call _fnc_createText;
    };

    _height = _itemY + _itemH;
    _spacing = POS_H(BODY_ITEM_SPACING);
} forEach getArray (_section >> "items");

// The line under the last row extends past the text
_ctrlBody ctrlSetPositionH (_height max _lineBottom);
_ctrlBody ctrlCommit 0;
_ctrlBody
