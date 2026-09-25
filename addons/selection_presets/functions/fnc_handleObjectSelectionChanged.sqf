#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles changes to the Zeus object selection.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_selection_presets_fnc_handleObjectSelectionChanged
 *
 * Public: No
 */

BEGIN_COUNTER(handleObjectSelectionChanged);

if (GVAR(enabled)) then {
    {
        if ([_x] call FUNC(isPresetSelected)) then {
            [_x] call FUNC(renderSelected);
        };
    } forEach PRESET_KEYS;
};

END_COUNTER(handleObjectSelectionChanged);
