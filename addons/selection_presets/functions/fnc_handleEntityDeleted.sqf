#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles an entity being deleted.
 *
 * Arguments:
 * 0: Entity <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [OBJECT] call zen_selection_presets_fnc_handleEntityDeleted
 *
 * Public: No
 */

params ["_entity"];

{
    private _preset = curatorSelectionPreset _x;

    if (_entity in _preset) then {
        _preset = _preset - [_entity, objNull];
        _x setCuratorSelectionPreset _preset;
    };
} forEach PRESET_KEYS;
