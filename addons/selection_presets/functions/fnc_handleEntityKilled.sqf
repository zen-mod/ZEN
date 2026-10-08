#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles an entity being killed.
 *
 * Arguments:
 * 0: Entity <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [OBJECT] call zen_selection_presets_fnc_handleEntityKilled
 *
 * Public: No
 */

params ["_entity"];

// Only units or vehicle icons need to be updated when their respective entity is killed
if (_entity isKindOf "AllVehicles") then {
    {
        private _preset = curatorSelectionPreset _x;

        if (_entity in _preset) then {
            [_x] call FUNC(queueRender);
        };
    } forEach PRESET_KEYS;
};
