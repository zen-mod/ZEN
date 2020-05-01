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
private _weaponIndex = lbCurSel (_display displayCtrl IDC_WEAPON);

private _weaponList = _display getVariable QGVAR(weaponList);
private _weapon = _weaponList select _weaponIndex;
_weapon params ["", "_turretPath", "_magazines"];

private _changes = _display getVariable QGVAR(changes);

{
    _x params ["_magazine", "_count"];

    if (_count != 0) then {
        // Set count to zero in weapons list
        _x set [1, 0];

        // Set count to zero in tracked magazine changes
        private _index = _changes findIf {(_x select 0) isEqualTo _turretPath && {(_x select 1) == _magazine}};

        if (_index == -1) then {
            _changes pushBack [_turretPath, _magazine, 0];
        } else {
            (_changes select _index) set [2, 0];
        };
    };
} forEach _magazines;

// Refresh the list after clearing
[_display] call FUNC(fillList);
