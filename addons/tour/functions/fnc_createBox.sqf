#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates a box of the given color within a controls group.
 * Used for shapes such as dividers and backgrounds.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Position <ARRAY>
 * 2: Color <ARRAY>
 *
 * Return Value:
 * Box <CONTROL>
 *
 * Example:
 * [CONTROL, [0, 0, 1, 1], [1, 1, 1, 0.1]] call zen_tour_fnc_createBox
 *
 * Public: No
 */

params ["_controlsGroup", "_position", "_color"];

private _ctrlBox = ctrlParent _controlsGroup ctrlCreate ["RscText", -1, _controlsGroup];
_ctrlBox ctrlSetPosition _position;
_ctrlBox ctrlSetBackgroundColor _color;
_ctrlBox ctrlSetPixelPrecision PIXEL_PRECISION;
_ctrlBox ctrlCommit 0;
_ctrlBox
