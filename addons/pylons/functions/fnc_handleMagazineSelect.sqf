#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles selecting a magazine in the pylon combo boxes.
 *
 * Arguments:
 * 0: Pylon Combo <CONTROL>
 * 1: Selected Index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_pylons_fnc_handleMagazineSelect
 *
 * Public: No
 */

params ["_ctrlCombo", "_selectedIndex"];

private _previousIndex = _ctrlCombo getVariable [QGVAR(previousIndex), 0];
_ctrlCombo setVariable [QGVAR(previousIndex), _selectedIndex];

// Exit if event handler was triggered by lbSetCurSel command
// Prevents issues with manually setting selection when loading a preset
EXIT_LOCKED;

private _display = ctrlParent _ctrlCombo;

// Mimic 3DEN pylons UI behaviour of selecting the custom preset if a different magazine is selected
if (_selectedIndex != _previousIndex) then {
    private _ctrlPresets = _display displayCtrl IDC_PRESETS;
    _ctrlPresets lbSetCurSel 0;
};

// Handle selecting the same magazine on the mirrored combo box
if (cbChecked (_display displayCtrl IDC_MIRROR)) then {
    private _pylonIndex = _ctrlCombo getVariable QGVAR(index);

    {
        _x params ["_ctrlComboMirrored", "", "_mirroredIndex"];

        if (_mirroredIndex == _pylonIndex) exitWith {
            _ctrlComboMirrored lbSetCurSel _selectedIndex;
        };
    } forEach (_display getVariable QGVAR(controls));
};
