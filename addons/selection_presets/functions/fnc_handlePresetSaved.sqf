#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles saving a selection preset.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Preset Key <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, 1] call zen_selection_presets_fnc_handlePresetSaved
 *
 * Public: No
 */

params ["", "_key"];

private _preset = curatorSelectionPreset _key;

// Filter objects from the preset based on the setting
switch (GVAR(excludeFromPresets)) do {
    case EXCLUDE_FROM_PRESETS_PROPS: {
        _preset = _preset select {
            _x isKindOf "AllVehicles" || {_x isKindOf "Logic"}
        };
    };
    case EXCLUDE_FROM_PRESETS_MODULES: {
        _preset = _preset select {
            !(_x isKindOf "Logic")
        };
    };
    case EXCLUDE_FROM_PRESETS_PROPS_AND_MODULES: {
        _preset = _preset select {
            _x isKindOf "AllVehicles" && {!(_x isKindOf "Logic")}
        };
    };
};

// Remove duplicate objects while preserving their order
// Needed because setCuratorSelectionPreset allows duplicate elements to be saved
_preset = _preset arrayIntersect _preset;

// Write corrected contents back (the resulting saved event will refresh the slot)
if (_preset isNotEqualTo curatorSelectionPreset _key) exitWith {
    _key setCuratorSelectionPreset _preset;
};

// Skip rendering changes if the bar is not shown
if (!GVAR(enabled)) exitWith {};

// Queue the slot to be rendered and refresh the layout
[_key, true] call FUNC(queueRender);

// Saving does not change the selection, so trigger the highlighting explicitly
if ([_key] call FUNC(isPresetSelected)) then {
    [_key] call FUNC(renderSelected);
};
