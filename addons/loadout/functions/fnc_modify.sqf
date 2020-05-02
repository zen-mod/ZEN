#include "script_component.hpp"
/*
 * Author: NeilZar
 * Handles adding or removing magazines from a weapon.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Add or Remove Magazine <BOOL>
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

// Get count of currently selected magazine
private _weaponIndex = lbCurSel (_display displayCtrl IDC_WEAPON);
private _weaponList = _display getVariable QGVAR(weaponList);

private _weapon = _weaponList select _weaponIndex;
_weapon params ["", "_turretPath", "_magazines"];

private _ctrlList = _display displayCtrl IDC_LIST;
private _magazineIndex = lnbCurSelRow _ctrlList;

private _magazine = _magazines select _magazineIndex;
_magazine params ["_magazineClass", "_count"];

if (_addItem) then {
    _count = _count + 1;
    _magazine set [1, _count];

    // Update count text and increase alpha
    _ctrlList lnbSetText  [[_magazineIndex, 2], str _count];
    _ctrlList lnbSetColor [[_magazineIndex, 0], [1, 1, 1, 1]];
    _ctrlList lnbSetColor [[_magazineIndex, 1], [1, 1, 1, 1]];
    _ctrlList lnbSetColor [[_magazineIndex, 2], [1, 1, 1, 1]];
};

if (!_addItem && {_count > 0}) then {
    _count = _count - 1;
    _magazine set [1, _count];

    // Update count text and decrease alpha if new count is zero
    private _alpha = [0.5, 1] select (_count != 0);
    _ctrlList lnbSetText  [[_magazineIndex, 2], str _count];
    _ctrlList lnbSetColor [[_magazineIndex, 0], [1, 1, 1, _alpha]];
    _ctrlList lnbSetColor [[_magazineIndex, 1], [1, 1, 1, _alpha]];
    _ctrlList lnbSetColor [[_magazineIndex, 2], [1, 1, 1, _alpha]];
};

// Update count in tracked magazine changes
private _changes = _display getVariable QGVAR(changes);
private _index = _changes findIf {(_x select 0) isEqualTo _turretPath && {(_x select 1) == _magazineClass}};

if (_index == -1) then {
    _changes pushBack [_turretPath, _magazineClass, _count];
} else {
    (_changes select _index) set [2, _count];
};

// Update the list buttons
[_display] call FUNC(updateButtons);
