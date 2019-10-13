#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns a list of all position logics (and their names) of the given type.
 *
 * Arguments:
 * 0: Type <STRING|OBJECT>
 *
 * Return Value:
 * Position Logic List <ARRAY>
 *   N: [Logic <OBJECT>, Name <STRING>] <ARRAY>
 *
 * Example:
 * [_logicType] call zen_position_logics_fnc_get
 *
 * Public: No
 */

params [["_type", "", ["", objNull]]];

if (_type isEqualType objNull) then {
    _type = typeOf _type;
};

private _list = missionNamespace getVariable [VAR_LIST(_type), []];
_list select {!isNull _x} apply {[_x, name _x]}
