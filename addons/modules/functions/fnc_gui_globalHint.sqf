#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Global Hint" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_modules_fnc_gui_globalHint
 *
 * Public: No
 */

params ["_display", "_logic"];

deleteVehicle _logic;

// Update the preview when the input text changes
private _fnc_update = {
    params ["_ctrlEdit"];

    private _display = ctrlParent _ctrlEdit;
    private _ctrlPreview = _display displayCtrl IDC_GLOBALHINT_PREVIEW;
    _ctrlPreview ctrlSetStructuredText parseText ctrlText _ctrlEdit;
    _ctrlPreview ctrlSetPositionH (ctrlTextHeight _ctrlPreview max 1);
    _ctrlPreview ctrlCommit 0;
};

private _ctrlEdit = _display displayCtrl IDC_GLOBALHINT_EDIT;
_ctrlEdit ctrlAddEventHandler ["KeyDown", _fnc_update];
_ctrlEdit ctrlAddEventHandler ["KeyUp", _fnc_update];

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _ctrlEdit = _display displayCtrl IDC_GLOBALHINT_EDIT;
    [QEGVAR(common,hint), parseText ctrlText _ctrlEdit] call CBA_fnc_globalEvent;
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
