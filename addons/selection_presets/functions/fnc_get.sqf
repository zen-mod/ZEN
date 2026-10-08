#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the objects saved for the given selection preset key.
 * If no key is given, then returns a nested array of all presets.
 *
 * Arguments:
 * 0: Preset Key <NUMBER> (default: nil)
 *   - Returns an array of all presets when omitted.
 *
 * Return Value:
 * Selection Preset(s) <ARRAY>
 *
 * Example:
 * [0] call zen_selection_presets_fnc_get
 *
 * Public: No
 */

params [["_key", nil, [0]]];

// curatorSelectionPreset can include objNull when the objects are deleted
if (isNil "_key") then {
    PRESET_KEYS apply {curatorSelectionPreset _x - [objNull]}
} else {
    curatorSelectionPreset _key - [objNull]
};
