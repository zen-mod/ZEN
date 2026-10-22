#include "script_component.hpp"
/*
 * Author: mharis001
 * Renders the title and description of a feature.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Position <ARRAY>
 *   - The height is determined by the content.
 * 2: Feature <CONFIG>
 *
 * Return Value:
 * Header <CONTROL>
 *
 * Example:
 * [CONTROL, [0, 0, 1], _feature] call zen_tour_fnc_renderHeader
 *
 * Public: No
 */

params ["_controlsGroup", "_position", "_feature"];
_position params ["_posX", "_posY", "_posW"];

private _ctrlHeader = ctrlParent _controlsGroup ctrlCreate ["RscControlsGroupNoScrollbars", -1, _controlsGroup];
_ctrlHeader ctrlSetPosition [_posX, _posY, _posW, 0];
_ctrlHeader ctrlCommit 0;

private _title = getText (_feature >> "title");
[_ctrlHeader, QGVAR(title), [0, 0, _posW, POS_H(HEADER_TITLE_HEIGHT)], _title] call FUNC(createText);

private _description = getText (_feature >> "description");
private _ctrlLead = [_ctrlHeader, QGVAR(lead), [0, POS_H(HEADER_LEAD_Y), _posW], _description] call FUNC(createText);
private _leadH = ctrlPosition _ctrlLead select 3;

_ctrlHeader ctrlSetPositionH (POS_H(HEADER_LEAD_Y) + _leadH);
_ctrlHeader ctrlCommit 0;
_ctrlHeader
