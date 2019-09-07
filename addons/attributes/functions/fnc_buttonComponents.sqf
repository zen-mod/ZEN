#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the sensors button.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_attributes_fnc_buttonSensors
 *
 * Public: No
 */

private _vehicle = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _components = [];
private _allHitPointsDamage = getAllHitPointsDamage _vehicle;

{
    private _component = _x;
    if (_component isEqualTo "") then {_component = _allHitPointsDamage select 1 select _forEachIndex};

    _components pushBack ["SLIDER:PERCENT", _component, [0, 1, _allHitPointsDamage select 2 select _forEachIndex], true];
} forEach (_allHitPointsDamage select 0);

[LSTRING(ComponentsDamage), _components, {
    params ["_dialogValues", "_vehicle"];

    [QGVAR(setAllHitPointsDamage), [_vehicle, _dialogValues], _vehicle] call CBA_fnc_targetEvent;
}, {}, _vehicle] call EFUNC(dialog,create);
