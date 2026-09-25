#include "script_component.hpp"
/*
 * Author: mharis001
 * Queues preset slots for rendering and optionally
 * requests a layout update.
 *
 * Arguments:
 * 0: Preset Key <NUMBER> (default: nil)
 * 1: Update Layout <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [1] call zen_selection_presets_fnc_queueRender
 *
 * Public: No
 */

params [["_key", nil], ["_updateLayout", false]];

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlPresets = _display displayCtrl IDC_PRESETS;
if (isNull _ctrlPresets) exitWith {};

private _renderQueue = _ctrlPresets getVariable [QGVAR(renderQueue), []];

if (isNil "_key") then {
    _renderQueue insert [-1, PRESET_KEYS, true];
} else {
    _renderQueue pushBackUnique _key;
};

if (_updateLayout) then {
    _ctrlPresets setVariable [QGVAR(layoutDirty), true];
};
