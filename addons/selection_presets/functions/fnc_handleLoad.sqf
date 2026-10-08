#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles initializing the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_selection_presets_fnc_handleLoad
 *
 * Public: No
 */

params ["_display"];

// Initially create the presets bar if needed
if (GVAR(enabled)) then {
    [_display] call FUNC(createBar);
};

// Restore persisted presets (needs frame delay)
if (GVAR(persistPresets)) then {
    {
        private _curator = getAssignedCuratorLogic player;
        private _presets = _curator getVariable [QGVAR(presets), []];

        {
            if (_x isNotEqualTo []) then {
                private _key = PRESET_KEYS select _forEachIndex;
                _key setCuratorSelectionPreset _x;
            };
        } forEach _presets;
    } call CBA_fnc_execNextFrame;
};
