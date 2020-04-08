#include "script_component.hpp"
/*
 * Author: NeilZar
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

{
    _x params ["_magazineClass", "_magazineCount"];

    if (_magazineCount != 0) then {
        _x set [1, 0];

        private _changeIndex = _changes findIf {(_x select 0) isEqualTo _turret && (_x select 1) == _magazineClass};
        if (_changeIndex == -1) then {
            _changes pushBack ([_turret] + _x);
        } else {
            _changes set [_changeIndex, [_turret] + _x];
        };
    };
} forEach _magazines;

// Update the list buttons
[_display] call FUNC(fillList);
