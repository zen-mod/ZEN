#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the given preset is selected.
 *
 * Arguments:
 * 0: Preset Key <NUMBER>
 *
 * Return Value:
 * Is Preset Selected <BOOL>
 *
 * Example:
 * [1] call zen_selection_presets_fnc_isPresetSelected
 *
 * Public: No
 */

params [["_key", 0, [0]]];

private _preset = [_key] call FUNC(get);
private _selectedObjects = SELECTED_OBJECTS;

_selectedObjects isNotEqualTo []
&& {count _preset == count _selectedObjects}
&& {_preset arrayIntersect _selectedObjects isEqualTo _preset}
