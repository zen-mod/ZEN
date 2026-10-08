#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles pressing a mouse button down on a slot control.
 *
 * Arguments:
 * 0: Mouse Area <CONTROL>
 * 1: Button <NUMBER>
 * 2: X Position (not used) <NUMBER>
 * 3: Y Position (not used) <NUMBER>
 * 4: Shift State <BOOL>
 * 5: Ctrl State <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, 0.5, 0.5, false, false] call zen_selection_presets_fnc_handleMouseButtonDown
 *
 * Public: No
 */

params ["_ctrlMouse", "_button", "", "", "_shift", "_ctrl"];

if (_button != 0) exitWith {};

switch (ctrlIDC _ctrlMouse) do {
    case IDC_SLOT_MOUSE: {
        private _ctrlSlot = ctrlParentControlsGroup _ctrlMouse;
        private _key = _ctrlSlot getVariable [QGVAR(key), -1];
        private _actionPerformed = true;

        if (_ctrl) then {
            // Append to the current preset if the shift key is pressed
            private _preset = if (_shift) then {
                private _objects = curatorSelectionPreset _key;
                _objects insert [-1, SELECTED_OBJECTS, true];
                _objects
            } else {
                SELECTED_OBJECTS
            };

            // Skip saving when the objects already match the preset
            // Common case for this would be trying to save nothing to an already empty slot
            // Does not account for exclusions but should be fine
            if (_preset isEqualTo curatorSelectionPreset _key) then {
                _actionPerformed = false;
            } else {
                _key setCuratorSelectionPreset _preset;
            };
        } else {
            loadCuratorSelectionPreset _key;
        };

        if (_actionPerformed) then {
            playSoundUI ["SoundClick", 0.03];
        };
    };
    case IDC_ADD_PRESET_MOUSE: {
        private _selection = SELECTED_OBJECTS;
        if (_selection isEqualTo []) exitWith {};

        private _presets = [] call FUNC(get);
        private _firstEmptyPreset = _presets findIf {_x isEqualTo []};
        if (_firstEmptyPreset == -1) exitWith {};

        private _key = PRESET_KEYS select _firstEmptyPreset;
        _key setCuratorSelectionPreset _selection;
        playSoundUI ["SoundClick", 0.03];
    };
};
