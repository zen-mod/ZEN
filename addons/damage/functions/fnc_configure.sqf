#include "script_component.hpp"
/*
 * Author: NeilZar
 * Creates a dialog to damage the components of the given vehicle.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle] call zen_damage_fnc_configure
 *
 * Public: No
 */

params ["_vehicle"];

private _vehicleName = getText (configOf _vehicle >> "displayName");
private _title = format [localize LSTRING(ComponentsDamage), _vehicleName];

private _components = [];
(getAllHitPointsDamage _vehicle) params ["_hitPointNames", "_selectionNames", "_damageValues"];

{
    private _component = _x;

    if (_component isEqualTo "") then {
        _component = _selectionNames select _forEachIndex;
    };

    private _componentName = _component call FUNC(getHitPointString);
    _components pushBack ["SLIDER:PERCENT", [_componentName, _component], [0, 1, _damageValues select _forEachIndex], true];
} forEach _hitPointNames;

[_title, _components, {
    params ["_values", "_vehicle"];

    private _vehicleType = typeOf _vehicle;

    {
        if (alive _x && {typeOf _x isEqualTo _vehicleType}) then {
            [QGVAR(setHitPointsDamage), [_x, _values], _x] call CBA_fnc_targetEvent;
        };
    } forEach call EFUNC(common,getSelectedVehicles);
}, {}, _vehicle] call EFUNC(dialog,create);
