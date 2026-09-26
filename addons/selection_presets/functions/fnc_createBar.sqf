#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates the selection presets bar.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_selection_presets_fnc_createBar
 *
 * Public: No
 */

params ["_display"];

// Skip creating the bar if it already exists
if (!isNull (_display displayCtrl IDC_PRESETS)) exitWith {};

// Create the bar container and its outer frame
private _ctrlPresets = _display ctrlCreate ["RscControlsGroupNoScrollbars", IDC_PRESETS];
private _ctrlPresetsFrame = _display ctrlCreate ["RscFrame", IDC_PRESETS_FRAME, _ctrlPresets];
_ctrlPresetsFrame ctrlSetTextColor [0, 0, 0, 1];

// Create the add button (the layout determines whether it is visible)
_display ctrlCreate [QGVAR(add), IDC_ADD_PRESET, _ctrlPresets];

// Create one slot per preset key
private _slotControls = createHashMap;

{
    private _ctrlSlot = _display ctrlCreate [QGVAR(slot), -1, _ctrlPresets];
    _ctrlSlot setVariable [QGVAR(key), _x];

    private _ctrlSlotKey = _ctrlSlot controlsGroupCtrl IDC_SLOT_KEY;
    _ctrlSlotKey ctrlSetText format ["%1", _x];

    _slotControls set [_x, _ctrlSlot];
} forEach PRESET_KEYS;

// Initialize the render state and hide the bar until the first layout pass
_ctrlPresets setVariable [QGVAR(slots), _slotControls];
_ctrlPresets setVariable [QGVAR(renderQueue), []];
_ctrlPresets setVariable [QGVAR(layoutDirty), true];
_ctrlPresets ctrlShow false;

// Disable pixel rounding to fix inconsistent borders
{
    _x ctrlSetPixelPrecision 2;
} forEach allControls _ctrlPresets;

// Track entity changes while the bar exists
private _eventHandlers = createHashMapFromArray [
    [
        "EntityDeleted",
        addMissionEventHandler ["EntityDeleted", {call FUNC(handleEntityDeleted)}]
    ],
    [
        "EntityKilled",
        addMissionEventHandler ["EntityKilled", {call FUNC(handleEntityKilled)}]
    ]
];

_display setVariable [QGVAR(eventHandlers), _eventHandlers];

// Start the render PFH
[LINKFUNC(render), 0, _ctrlPresets] call CBA_fnc_addPerFrameHandler;
