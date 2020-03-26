#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clearing all magazines from the current weapon.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_loadout_fnc_clear
 *
 * Public: No
 */

params ["_ctrlButtonClear"];

private _display = ctrlParent _ctrlButtonClear;
private _comboWeapon = _display displayCtrl IDC_WEAPON;
private _weaponIndex = lbCurSel _comboWeapon;

private _weaponList = _display getVariable QGVAR(weaponList);
private _weapon = _weaponList select _weaponIndex;
_weapon params ["", "_turret", "_magazines"];

private _changes = _display getVariable QGVAR(changes);
TRACE_1("Changes before",_changes);
{
    private _magazine = _x;
    if (_magazine select 1 != 0) then {
        _magazine set [1, 0];

        private _changeIndex = _changes findIf {(_x select 0) isEqualTo _turret && (_x select 1) == (_magazine select 0)};
        if (_changeIndex == -1) then {
            _changes pushBack ([_turret] + _x);
        } else {
            _changes set [_changeIndex, [_turret] + _x];
        };
    };
} forEach _magazines;
TRACE_1("Changes after",_changes);
_weapon set [2, _magazines];
_weaponList set [_weaponIndex, _weapon];

// Update the list buttons
[_display] call FUNC(fillList);
