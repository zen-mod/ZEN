#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes a combo or list box with entries for position logics of the given type.
 * If the position arugment is not nil, the distance from each logic to the position will be displayed.
 *
 * Arguments:
 * 0: List <CONTROL>
 * 1: Type <STRING|OBJECT>
 * 2: Default Value <NUMBER>
 * 3: Include None <BOOL>
 * 4: Position <OBJECT|ARRAY> (default: nil)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_ctrlList, _logicType, 0, false] call zen_position_logics_fnc_initList
 *
 * Public: No
 */

params [
    ["_ctrlList", controlNull, [controlNull]],
    ["_type", "", ["", objNull]],
    ["_default", 0, [0]],
    ["_includeNone", false, [false]],
    ["_position", nil, [objNull, []], 3]
];

if (_type isEqualType objNull) then {
    _type = typeOf _type;
};

private _list = _type call FUNC(get);

// Ensure that the list is clear before adding entries
lbClear _ctrlList;

// Add "None" option if needed
if (_includeNone) then {
    private _index = _ctrlList lbAdd localize "STR_A3_None";
    _ctrlList lbSetPicture [_index, "\a3\ui_f_curator\data\default_ca.paa"];
    _ctrlList lbSetValue [_index, -4];

    // Handle correctly selecting default item
    _default = _default + 1;
};

// Disable the list if no position logics exist
if (_list isEqualTo []) exitWith {
    _ctrlList lbSetCurSel 0;
    _ctrlList ctrlEnable false;
};

// Add "Random", "Nearest", "Farthest" options
{
    _x params ["_text", "_icon", "_value"];

    private _index = _ctrlList lbAdd localize _text;
    _ctrlList lbSetPicture [_index, _icon];
    _ctrlList lbSetValue [_index, _value];
} forEach [
    ["str_3den_attributes_objecttexture_random_text", QPATHTOF(ui\random_ca.paa), -3],
    [ELSTRING(common,Nearest), QPATHTOF(ui\nearest_ca.paa), -2],
    [ELSTRING(common,Farthest), QPATHTOF(ui\farthest_ca.paa), -1]
];

// Add specific position logics of the given type
private _icon = getText (configFile >> "CfgVehicles" >> _type >> "icon");

{
    private _index = _ctrlList lbAdd name _x;
    _ctrlList lbSetPicture [_index, _icon];
    _ctrlList lbSetValue [_index, _forEachIndex];

    // If a position is given, show distance to the logic
    if (!isNil "_position") then {
        private _distance = [(_x distance _position) / 1000, 1, 2] call CBA_fnc_formatNumber;
        _ctrlList lbSetTextRight [_index, format [localize LSTRING(DistanceKM), _distance]];
    };
} forEach _list;

_ctrlList lbSetCurSel (_default + 3);
