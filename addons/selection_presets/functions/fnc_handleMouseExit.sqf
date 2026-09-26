#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles moving the mouse off of a slot control.
 *
 * Arguments:
 * 0: Mouse Area <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_selection_presets_fnc_handleMouseExit
 *
 * Public: No
 */

params ["_ctrlMouse"];

private _params = switch (ctrlIDC _ctrlMouse) do {
    case IDC_SLOT_MOUSE: {
        [IDC_SLOT_KEY, [0, 0, 0, 0.5]]
    };
    case IDC_ADD_PRESET_MOUSE: {
        [IDC_ADD_PRESET_BACKGROUND, [0.1, 0.1, 0.1, 0.5]]
    };
};

_params params ["_backgroundIDC", "_backgroundColor"];

private _ctrlParent = ctrlParentControlsGroup _ctrlMouse;
private _ctrlBackground = _ctrlParent controlsGroupCtrl _backgroundIDC;
_ctrlBackground ctrlSetBackgroundColor _backgroundColor;
