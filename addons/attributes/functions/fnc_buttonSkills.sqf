#include "script_component.hpp"
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

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _unit   = if (_entity isEqualType grpNull) then {leader _entity} else {_entity};

[LSTRING(ChangeSkills), [
    ["SLIDER:PERCENT", "STR_General",               [0, 1, _unit skill "general"       ], true],
    ["SLIDER:PERCENT", ELSTRING(ai,AimingAccuracy), [0, 1, _unit skill "aimingAccuracy"], true],
    ["SLIDER:PERCENT", ELSTRING(ai,AimingSpeed),    [0, 1, _unit skill "aimingSpeed"   ], true],
    ["SLIDER:PERCENT", ELSTRING(ai,AimingShake),    [0, 1, _unit skill "aimingShake"   ], true],
    ["SLIDER:PERCENT", ELSTRING(ai,Commanding),     [0, 1, _unit skill "commanding"    ], true],
    ["SLIDER:PERCENT", ELSTRING(ai,Courage),        [0, 1, _unit skill "courage"       ], true],
    ["SLIDER:PERCENT", ELSTRING(ai,SpotDistance),   [0, 1, _unit skill "spotDistance"  ], true],
    ["SLIDER:PERCENT", ELSTRING(ai,SpotTime),       [0, 1, _unit skill "spotTime"      ], true],
    ["SLIDER:PERCENT", ELSTRING(ai,ReloadSpeed),    [0, 1, _unit skill "reloadSpeed"   ], true]
], {
    params ["_values", "_entity"];

    {
        [QGVAR(setSkills), [_x, _values], _x] call CBA_fnc_targetEvent;
    } forEach (_entity call FUNC(getAttributeEntities));
}, {}, _entity] call EFUNC(dialog,create);
