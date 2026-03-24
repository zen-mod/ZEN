#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles selecting a pylons preset in the presets combo box.
 *
 * Arguments:
 * 0: Presets Combo <CONTROL>
 * 1: Selected Index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_pylons_fnc_handlePreset
 *
 * Public: No
 */

params ["_ctrlPresets", "_selectedIndex"];

// Exit on custom pylon configuration
if (_selectedIndex == 0) exitWith {};

// Disable mirroring when selecting a preset
private _display = ctrlParent _ctrlPresets;
[_display, false] call FUNC(handleMirror);

private _ctrlMirror = _display displayCtrl IDC_MIRROR;
_ctrlMirror cbSetChecked false;

// Select the preset's magazines and default pylon turrets
private _presetMagazines = _ctrlPresets getVariable str _selectedIndex;

{
    _x params ["_ctrlCombo", "_ctrlTurret", "", "_turretPath"];

    private _magazine = _presetMagazines param [_forEachIndex, ""];

    for "_index" from 0 to (lbSize _ctrlCombo - 1) do {
        if (_ctrlCombo lbData _index == _magazine) exitWith {
            LB_LOCK;
            _ctrlCombo lbSetCurSel _index;
            LB_UNLOCK;
        };
    };

    _ctrlTurret setVariable [QGVAR(turretPath), _turretPath];
    _ctrlTurret call FUNC(handleTurretButton);
} forEach (_display getVariable QGVAR(controls));
