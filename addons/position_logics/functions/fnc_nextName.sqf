#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the next unique name for position logics of the given type.
 *
 * Arguments:
 * 0: Type <STRING|OBJECT>
 * 1: Format <STRING> (default: "%1")
 *
 * Return Value:
 * Name <STRING>
 *
 * Example:
 * [_logicType] call zen_position_logics_fnc_nextName
 *
 * Public: No
 */

params [["_type", "", ["", objNull]], ["_format", "%1", [""]]];

if (_type isEqualType objNull) then {
    _type = typeOf _type;
};

if (isLocalized _format) then {
    _format = localize _format;
};

private _nextID = missionNamespace getVariable [VAR_NEXTID(_type), 0];

format [_format, _nextID call EFUNC(common,getPhoneticName)]
