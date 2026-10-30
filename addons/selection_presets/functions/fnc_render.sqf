#include "script_component.hpp"
/*
 * Author: mharis001
 * Renders the selection presets bar.
 *
 * Arguments:
 * 0: Preset Bar Control <CONTROL>
 * 1: PFH Handle <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 1] call zen_selection_presets_fnc_render
 *
 * Public: No
 */

BEGIN_COUNTER(render);

params ["_ctrlPresets", "_pfhID"];

if (isNull _ctrlPresets) exitWith {
    [_pfhID] call CBA_fnc_removePerFrameHandler;
    END_COUNTER(render);
};

// Hide the presets bar when the display is in screenshot mode and
// skip any rendering while it is hidden
private _isInScreenshotMode = call EFUNC(common,isInScreenshotMode);
private _isHidden = _ctrlPresets getVariable [QGVAR(hidden), false];

if (_isInScreenshotMode isNotEqualTo _isHidden) then {
    _ctrlPresets setVariable [QGVAR(hidden), _isInScreenshotMode];

    // Matching RscDisplayCurator.sqf using 0.1 for fade transitions
    _ctrlPresets ctrlSetFade parseNumber _isInScreenshotMode;
    _ctrlPresets ctrlCommit 0.1;

    // Allow interactions through the hidden UI element
    _ctrlPresets ctrlEnable !_isInScreenshotMode;
};

if (_isInScreenshotMode) exitWith {
    END_COUNTER(render);
};

// If the layout has been invalidated, refresh it before rendering the individual slots
private _layoutDirty = _ctrlPresets getVariable [QGVAR(layoutDirty), false];

if (_layoutDirty) then {
    _ctrlPresets setVariable [QGVAR(layoutDirty), false];
    _ctrlPresets call FUNC(renderLayout);
};

// Process the accumulated slot rendering updates once per frame
private _renderQueue = _ctrlPresets getVariable [QGVAR(renderQueue), []];

if (_renderQueue isNotEqualTo []) then {
    private _slotControls = _ctrlPresets getVariable [QGVAR(slots), createHashMap];

    {
        private _ctrlSlot = _slotControls get _x;

        // If a slot is not visible, then we don't need to update it
        // This can happen if the slot's preset became empty and the empty slot mode
        // is set to hide empty slots
        if (ctrlShown _ctrlSlot) then {
            [_ctrlSlot] call FUNC(renderSlot);
        };
    } forEach _renderQueue;

    _renderQueue resize 0;
};

END_COUNTER(render);
