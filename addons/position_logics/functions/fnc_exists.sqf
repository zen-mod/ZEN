#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if a position logic of the given type exists.
 *
 * Arguments:
 * 0: Type <STRING|OBJECT>
 *
 * Return Value:
 * Position Logic Exists <BOOL>
 *
 * Example:
 * [_logicType] call zen_position_logics_fnc_exists
 *
 * Public: No
 */

params [["_type", "", ["", objNull]]];

if (_type isEqualType objNull) then {
    _type = typeOf _type;
};

private _list = missionNamespace getVariable [VAR_LIST(_type), []];

!(_list isEqualTo [])
