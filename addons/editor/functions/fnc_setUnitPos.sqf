#include "..\script_component.hpp"
/*
 * Authors: Timi007
 * Sets the stance of a unit and shows an icon as hint.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Stance ("UP", "MIDDLE", "DOWN", "AUTO") <STRING>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [cursorObject, "UP"] call zen_editor_fnc_setUnitPos
 *
 * Public: No
 */

params ["_unit", "_stance"];

if (
    isNull _unit ||
    {isPlayer _unit} ||
    {!alive _unit} ||
    {!isNull objectParent _unit} ||
    {unitPos _unit == _stance}
) exitWith {false};

[QEGVAR(common,setUnitPos), [_unit, _stance], _unit] call CBA_fnc_targetEvent;

private _white = [1, 1, 1, 1];
private _iconProperties = switch (_stance) do {
    case "UP":     {[_unit, "\a3\3DEN\Data\Attributes\Stance\up_ca.paa",     _white, 1.5]};
    case "MIDDLE": {[_unit, "\a3\3DEN\Data\Attributes\Stance\middle_ca.paa", _white, 1.5]};
    case "DOWN":   {[_unit, "\a3\3DEN\Data\Attributes\Stance\down_ca.paa",   _white, 1.5]};
    case "AUTO":   {[_unit, "\a3\3DEN\Data\Attributes\default_ca.paa",       _white, 1]};
};

[[
    ["ICON", _iconProperties]
], 3, _unit] call EFUNC(common,drawHint);

true
