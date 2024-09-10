#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles toggling the mirror state of the pylons.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Mirrored <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, true] call zen_pylons_fnc_handleMirror
 *
 * Public: No
 */

params ["_display", "_mirrored"];

private _controls = _display getVariable QGVAR(controls);

if (_mirrored) then {
    // Mirror current configuration and disable mirrored combo boxes and turret buttons
    {
        _x params ["_ctrlCombo", "_ctrlTurret", "_mirroredIndex"];

        if (_mirroredIndex != -1) then {
            (_controls select _mirroredIndex) params ["_ctrlComboMirrored", "_ctrlTurretMirrored"];

            _ctrlCombo lbSetCurSel lbCurSel _ctrlComboMirrored;
            _ctrlCombo ctrlEnable false;

            private _turretPath = _ctrlTurretMirrored getVariable QGVAR(turretPath);
            _ctrlTurret setVariable [QGVAR(turretPath), _turretPath];
            _ctrlTurret call FUNC(handleTurretButton);
            _ctrlTurret ctrlEnable false;
        };
    } forEach _controls;
} else {
    // Enable all combo boxes and turret buttons if pylons are not mirrored
    {
        _x params ["_ctrlCombo", "_ctrlTurret"];

        _ctrlCombo ctrlEnable true;
        _ctrlTurret ctrlEnable true;
    } forEach _controls;
};
