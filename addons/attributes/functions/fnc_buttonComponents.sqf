#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the damage button.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_attributes_fnc_buttonComponents
 *
 * Public: No
 */

private _vehicle = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _components = [];
(getAllHitPointsDamage _vehicle) params ["_allHitPointNames", "_allHitSelectionNames", "_allHitPointsDamage"];

{
    private _component = _x;
    if (_component isEqualTo "") then { _component = _allHitSelectionNames select _forEachIndex };

    private _componentName = [_component, LSTRING(_component)] select (isLocalized LSTRING(_component));

    _components pushBack ["SLIDER:PERCENT", [_componentName, _component], [0, 1, _allHitPointsDamage select _forEachIndex], true];
} forEach _allHitPointNames;

[LSTRING(ComponentsDamage), _components, {
    params ["_dialogValues", "_vehicle"];
    private _vehicleType = typeOf _vehicle;

    {
        if (typeOf _x isEqualTo _vehicleType) then {
            [QGVAR(setAllHitPointsDamage), [_x, _dialogValues], _x] call CBA_fnc_targetEvent;
        };
    } forEach (_vehicle call FUNC(getAttributeEntities));
}, {}, _vehicle] call EFUNC(dialog,create);
