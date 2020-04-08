#include "script_component.hpp"
/*
 * Author: NeilZar
 * Handles adding or removing magazines to a weapon.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Add or Remove Item <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, true] call zen_loadout_fnc_modify
 *
 * Public: No
 */

params ["_display", "_addItem"];

// Get currently selected item and its mass
private _comboWeapon = _display displayCtrl IDC_WEAPON;
private _weaponIndex = lbCurSel _comboWeapon;

private _ctrlList = _display displayCtrl IDC_LIST;
private _magazineIndex = lnbCurSelRow _ctrlList;

private _weaponList = _display getVariable QGVAR(weaponList);
private _weapon = _weaponList select _weaponIndex;
_weapon params ["", "_turret", "_magazines"];
private _magazine = _magazines select _magazineIndex;
_magazine params ["_magazineClass", "_count"];

if (_addItem) then {
    _count = _count + 1;
    _magazine set [1, _count];

    // Update count text and increase alpha
    _ctrlList lnbSetText  [[_magazineIndex, 1], str _count];
    _ctrlList lnbSetColor [[_magazineIndex, 0], [1, 1, 1, 1]];
    _ctrlList lnbSetColor [[_magazineIndex, 1], [1, 1, 1, 1]];
};

if (!_addItem && {_count > 0}) then {
    _count = _count - 1;
    _magazine set [1, _count];

    // Update count text and decrease alpha if new count is zero
    private _alpha = [0.5, 1] select (_count != 0);
    _ctrlList lnbSetText  [[_magazineIndex, 1], str _count];
    _ctrlList lnbSetColor [[_magazineIndex, 0], [1, 1, 1, _alpha]];
    _ctrlList lnbSetColor [[_magazineIndex, 1], [1, 1, 1, _alpha]];
};

private _changes = _display getVariable QGVAR(changes);

private _changeIndex = _changes findIf {(_x select 0) isEqualTo _turret && (_x select 1) == (_magazineClass)};
if (_changeIndex == -1) then {
    _changes pushBack ([_turret] + _magazine);
} else {
    _changes set [_changeIndex, [_turret] + _magazine];
};

// Update the list buttons
[_display] call FUNC(updateButtons);
