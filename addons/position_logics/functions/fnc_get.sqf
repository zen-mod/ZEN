#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns a list of all position logics of the given type.
 *
 * Arguments:
 * 0: Type <STRING|OBJECT>
 *
 * Return Value:
 * Position Logics <ARRAY>
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

missionNamespace getVariable [VAR_LIST(_type), []] select {!isNull _x}
