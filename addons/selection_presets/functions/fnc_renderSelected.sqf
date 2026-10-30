#include "script_component.hpp"
/*
 * Author: mharis001
 * Renders the given preset's slot control as being selected.
 *
 * Arguments:
 * 0: Preset Key <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [1] call zen_selection_presets_fnc_renderSelected
 *
 * Public: No
 */

params ["_key"];

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlPresets = _display displayCtrl IDC_PRESETS;
private _slotControls = _ctrlPresets getVariable [QGVAR(slots), createHashMap];
private _ctrlSlot = _slotControls get _key;

// Avoid starting another selection watcher for an already highlighted slot
private _highlighted = _ctrlSlot getVariable [QGVAR(highlighted), false];
if (_highlighted) exitWith {};

_ctrlSlot setVariable [QGVAR(highlighted), true];

// Apply the highlight while the preset matches the current selection
private _ctrlSlotBackground = _ctrlSlot controlsGroupCtrl IDC_SLOT_BACKGROUND;
_ctrlSlotBackground ctrlSetBackgroundColor call EFUNC(common,getThemeColor);

// Unfortunately, there is no realiable event to capture this state change
// so we have to poll for it. CuratorObjectSelectionChanged does not fire
// when the entire selection is cleared
[{
    BEGIN_COUNTER(renderSelected);

    params ["_ctrlSlot", "_key"];

    if (
        !GVAR(enabled)
        || {isNull _ctrlSlot}
        || {
            private _isPresetSelected = [_key] call FUNC(isPresetSelected);
            !_isPresetSelected
        }
    ) exitWith {
        END_COUNTER(renderSelected);
        true
    };

    END_COUNTER(renderSelected);

    false
}, {
    params ["_ctrlSlot"];

    if (isNull _ctrlSlot) exitWith {};

    private _ctrlSlotBackground = _ctrlSlot controlsGroupCtrl IDC_SLOT_BACKGROUND;
    _ctrlSlotBackground ctrlSetBackgroundColor [0.1, 0.1, 0.1, 0.5];
    _ctrlSlot setVariable [QGVAR(highlighted), false];
}, [_ctrlSlot, _key]] call CBA_fnc_waitUntilAndExecute;
