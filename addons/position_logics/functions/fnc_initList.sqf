#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes a combo or list box with entries for position logics of the given type.
 *
 * Arguments:
 * 0: List <CONTROL>
 * 1: Type <STRING|OBJECT>
 * 2: Default Value <NUMBER>
 * 3: Include None <BOOL>
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
    ["_includeNone", false, [false]]
];

if (_type isEqualType objNull) then {
    _type = typeOf _type;
};

private _list = missionNamespace getVariable [VAR_LIST(_type), []];

// Ensure the combo or list box is clear before adding entries
lbClear _ctrlList;

// Add "None" option if needed
if (_includeNone) then {
    _ctrlList lbSetValue [_ctrlList lbAdd localize "STR_A3_None", -4];

    _default = _default + 1; // Extra option
};

// Disable the list if no position logics of this type exist
if (_list isEqualTo []) exitWith {
    _ctrlList lbSetCurSel 0;
    _ctrlList ctrlEnable false;
};

// Add "Random", "Nearest", "Farthest" options
{
    _x params ["_text", "_value"];

    _ctrlList lbSetValue [_ctrlList lbAdd localize _text, _value];
} forEach [
    ["str_3den_attributes_objecttexture_random_text", -3],
    [ELSTRING(common,Nearest), -2],
    [ELSTRING(common,Farthest), -1]
];

// Add names of position logics of the given type
{
    _ctrlList lbSetValue [_ctrlList lbAdd name _x, _forEachIndex];
} forEach _list;

_ctrlList lbSetCurSel (_default + 3);
