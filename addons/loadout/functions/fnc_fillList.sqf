#include "script_component.hpp"
/*
 * Author: NeilZar
 * Populates the listbox with items from the current weapon.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_loadout_fnc_fillList
 *
 * Public: No
 */

params ["_display"];

private _vehicle = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _weaponIndex = lbCurSel (_display displayCtrl IDC_WEAPON);
private _weapon = (_display getVariable QGVAR(weapons)) select _weaponIndex;
private _filter = toLower ctrlText (_display displayCtrl IDC_SEARCH_BAR);

private _ctrlList = _display displayCtrl IDC_LIST;
lnbClear _ctrlList;

private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgWeapon = configFile >> "CfgWeapons" >> _weapon select 0;

private _allMagazines = [];
{
    _allMagazines append getArray (
        (if (_x isEqualTo "this") then { _cfgWeapon } else { _cfgWeapon >> _x }) >> "magazines"
    )
} forEach getArray (_cfgWeapon >> "muzzles");

{
    private _displayName = getText (_cfgMagazines >> _x >> "displayName");
    if (toLower _displayName find _filter != -1) then {
        private _rounds = getNumber (_cfgMagazines >> _x >> "count");
        private _toolTip = format ["%1\n%2 Rounds\n%3", _displayName, _rounds, _x];
        private _alpha = 0.5;

        private _magazine = _x;
        private _count = { _x == _magazine } count (_vehicle magazinesTurret (_weapon select 1));

        if (_count > 0) then { _alpha = 1; };

        private _index = _ctrlList lnbAddRow [(format ["%1 (%2 Rounds)", _displayName, _rounds]), str _count];
        _ctrlList lnbSetData    [[_index, 0], _x];
        _ctrlList lnbSetColor   [[_index, 0], [1, 1, 1, _alpha]];
        _ctrlList lnbSetColor   [[_index, 1], [1, 1, 1, _alpha]];
        _ctrlList lbSetTooltip  [_index * count lnbGetColumnsPosition _ctrlList, _tooltip];
    };
} forEach _allMagazines;

_ctrlList lnbSort [1];

[_display] call FUNC(updateButtons);
