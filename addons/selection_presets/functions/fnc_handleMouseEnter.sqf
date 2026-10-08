#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles moving the mouse onto a slot control.
 *
 * Arguments:
 * 0: Mouse Area <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_selection_presets_fnc_handleMouseEnter
 *
 * Public: No
 */

params ["_ctrlMouse"];

private _backgroundIDC = switch (ctrlIDC _ctrlMouse) do {
    case IDC_SLOT_MOUSE: {IDC_SLOT_KEY};
    case IDC_ADD_PRESET_MOUSE: {IDC_ADD_PRESET_BACKGROUND};
};

private _ctrlParent = ctrlParentControlsGroup _ctrlMouse;
private _ctrlBackground = _ctrlParent controlsGroupCtrl _backgroundIDC;
_ctrlBackground ctrlSetBackgroundColor [0, 0, 0, 1];
