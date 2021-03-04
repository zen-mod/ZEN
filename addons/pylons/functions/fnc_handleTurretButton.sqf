#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles setting/toggling the state of pylon turret buttons.
 *
 * Arguments:
 * 0: Turret Button <CONTROL>
 * 1: Toggle <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, true] call zen_pylons_fnc_handleTurretButton
 *
 * Public: No
 */

params ["_ctrlTurret", ["_toggle", false]];

private _turretPath = _ctrlTurret getVariable QGVAR(turretPath);

// Toggle between driver and gunner turret if required
if (_toggle) then {
    _turretPath = [[-1], [0]] select (_turretPath isEqualTo [-1]);
    _ctrlTurret setVariable [QGVAR(turretPath), _turretPath];

    private _display = ctrlParent _ctrlTurret;

    // Handle toggling the state of the mirrored pylon's button
    if (cbChecked (_display displayCtrl IDC_MIRROR)) then {
        private _pylonIndex = _ctrlTurret getVariable QGVAR(index);

        {
            _x params ["", "_ctrlTurretMirrored", "_mirroredIndex"];

            if (_mirroredIndex == _pylonIndex) exitWith {
                _ctrlTurretMirrored setVariable [QGVAR(turretPath), _turretPath];
                _ctrlTurretMirrored call FUNC(handleTurretButton);
            };
        } forEach (_display getVariable QGVAR(controls));
    };
};

// Update the button's icon and tooltip
if (_turretPath isEqualTo [-1]) then {
    _ctrlTurret ctrlSetText ICON_DRIVER;
    _ctrlTurret ctrlSetTooltip localize "STR_Driver";
} else {
    _ctrlTurret ctrlSetText ICON_GUNNER;
    _ctrlTurret ctrlSetTooltip localize "STR_Gunner";
};
