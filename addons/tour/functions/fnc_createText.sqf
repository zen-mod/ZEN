#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates a text control of the given class within a controls group.
 * Structured text is resized to the height of its content.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Class <STRING>
 * 2: Position <ARRAY>
 *   - The height can be omitted for structured text.
 * 3: Text <STRING>
 *
 * Return Value:
 * Text <CONTROL>
 *
 * Example:
 * [CONTROL, "RscText", [0, 0, 1], "Text"] call zen_tour_fnc_createText
 *
 * Public: No
 */

params ["_controlsGroup", "_class", "_position", "_text"];
_position params ["_posX", "_posY", "_posW", ["_posH", 0]];

private _ctrlText = ctrlParent _controlsGroup ctrlCreate [_class, -1, _controlsGroup];

// Widened by the built-in margins of text controls, so that the text itself lines up with other content
_ctrlText ctrlSetPosition [_posX - TEXT_MARGIN, _posY, _posW + 2 * TEXT_MARGIN, _posH];
_ctrlText ctrlCommit 0;

if (ctrlType _ctrlText == CT_STRUCTURED_TEXT) then {
    private _structuredText = [_text] call FUNC(toStructuredText);
    _ctrlText ctrlSetStructuredText _structuredText;
    _ctrlText ctrlSetPositionH ctrlTextHeight _ctrlText;
    _ctrlText ctrlCommit 0;
} else {
    _ctrlText ctrlSetText _text;
};

_ctrlText
