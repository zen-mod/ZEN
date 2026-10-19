#include "..\script_component.hpp"
/*
 * Authors: Timi007
 * Sets the stance of the units and shows an icon as hint.
 *
 * Arguments:
 * 0: Unit(s) <OBJECT or ARRAY>
 * 1: Stance ("UP", "MIDDLE", "DOWN", "AUTO") <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject, "UP"] call zen_editor_fnc_switchStance
 *
 * Public: No
 */

params [["_units", [], [objNull, []]], ["_stance", "AUTO", [""]]];

if (_units isEqualType objNull) then {
    _units = [_units];
};

private _color = [1, 1, 1, 1];
private _iconProperties = switch (_stance) do {
    case "UP":     {["\a3\3DEN\Data\Attributes\Stance\up_ca.paa",     _color, 1.5]};
    case "MIDDLE": {["\a3\3DEN\Data\Attributes\Stance\middle_ca.paa", _color, 1.5]};
    case "DOWN":   {["\a3\3DEN\Data\Attributes\Stance\down_ca.paa",   _color, 1.5]};
    case "AUTO":   {["\a3\3DEN\Data\Attributes\default_ca.paa",       _color, 1]};
};

{
    if (
        !alive _x
        || {isPlayer _x}
        || {!isNull objectParent _x}
        || {unitPos _x == _stance}
    ) then {continue};

    [QEGVAR(common,setUnitPos), [_x, _stance], _x] call CBA_fnc_targetEvent;

    [[
        ["ICON", [_x] + _iconProperties]
    ], 3, _x, 1] call EFUNC(common,drawHint);
} forEach _units;
