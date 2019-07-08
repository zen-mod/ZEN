/*
 * Author: mharis001
 * Handles clicking the skills button.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_attributes_fnc_buttonSkills
 *
 * Public: No
 */
#include "script_component.hpp"

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _unit   = if (_entity isEqualType grpNull) then {leader _entity} else {_entity};

[LSTRING(ChangeSkills), [
    ["SLIDER:PERCENT", LSTRING(AimingAccuracy), [0, 1, _unit skill "aimingAccuracy"], true],
    ["SLIDER:PERCENT", LSTRING(AimingSpeed),    [0, 1, _unit skill "aimingSpeed"   ], true],
    ["SLIDER:PERCENT", LSTRING(AimingShake),    [0, 1, _unit skill "aimingShake"   ], true],
    ["SLIDER:PERCENT", LSTRING(Commanding),     [0, 1, _unit skill "commanding"    ], true],
    ["SLIDER:PERCENT", LSTRING(Courage),        [0, 1, _unit skill "courage"       ], true],
    ["SLIDER:PERCENT", LSTRING(SpotDistance),   [0, 1, _unit skill "spotDistance"  ], true],
    ["SLIDER:PERCENT", LSTRING(SpotTime),       [0, 1, _unit skill "spotTime"      ], true],
    ["SLIDER:PERCENT", LSTRING(ReloadSpeed),    [0, 1, _unit skill "reloadSpeed"   ], true]
], {
    params ["_dialogValues", "_entity"];

    {
        [QGVAR(setSkills), [_x, _dialogValues], _x] call CBA_fnc_targetEvent;
    } forEach (_entity call FUNC(getAttributeEntities));
}, {}, _entity] call EFUNC(dialog,create);
