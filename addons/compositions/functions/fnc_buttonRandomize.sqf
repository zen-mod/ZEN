#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles pressing the randomize button in the custom compositions panel.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_compositions_fnc_buttonRandomize
 *
 * Public: No
 */

params ["_ctrlRandomize"];

GVAR(randomize) = !GVAR(randomize);

private _color = [[1, 1, 1, 0.25], [1, 1, 1, 1]] select GVAR(randomize);
_ctrlRandomize ctrlSetTextColor _color;

private _tooltip = [LSTRING(RandomizationOff), LSTRING(RandomizationOn)] select GVAR(randomize);
_ctrlRandomize ctrlSetTooltip localize _tooltip;
