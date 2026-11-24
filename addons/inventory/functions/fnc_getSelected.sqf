#include "script_component.hpp"
/*
 * Author: Brett
 * Returns information about the currently selected item in the inventory display's list.
 * Weapon rows store their full weapon items array so that attachments and magazines are preserved.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * Selected <ARRAY>
 *   0: Item class name <STRING>
 *   1: Cargo entry (class name, or weapon items array for weapons) <STRING|ARRAY>
 *   2: Mass <NUMBER>
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_getSelected
 *
 * Public: No
 */

params ["_display"];

private _ctrlList = _display displayCtrl IDC_LIST;
private _currentRow = lnbCurSelRow _ctrlList;
private _item = _ctrlList lnbData [_currentRow, 0];
private _weapon = _ctrlList lnbData [_currentRow, 1];

if (_weapon == "") exitWith {
    [_item, _item, _item call FUNC(getItemMass)]
};

_weapon = parseSimpleArray _weapon;

[_item, _weapon, [_weapon] call FUNC(getWeaponMass)]
