/*
 * Author: Bohemia Interactive, mharis001
 * Show Zeus attributes window for an entity.
 * Edited to allow player editing and improve code.
 *
 * Arguments:
 * 0: Entity <OBJECT|GROUP|ARRAY|STRING>
 *
 * Return Value:
 * Window opened <BOOL>
 *
 * Example:
 * [unit] call BIS_fnc_showCuratorAttributes
 *
 * Public: No
 */
#include "script_component.hpp"

// Prevent attributes from opening if remote controlling (cannot override double click EH)
if (!isNull (missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", objNull])) exitWith {};

// Need [_this] for passed waypoint arrays
[_this] params [["_entity", objNull, [objNull, grpNull, [], ""]]];

// Opening attributes disabled for object
if (_entity isEqualType objNull && {_entity getVariable [QGVAR(disable), false]}) exitWith {};

private _curator = getAssignedCuratorLogic player;
private _curatorInfoType = switch (typeName _entity) do {
    case (typeName objNull): {
		private _infoTypeClass = if (isNull group _entity && {side _entity != sideLogic}) then {"curatorInfoTypeEmpty"} else {"curatorInfoType"};
        getText (configfile >> "CfgVehicles" >> typeOf _entity >> _infoTypeClass);
    };
	case (typeName grpNull): {
        getText (configFile >> "CfgCurator" >> "groupInfoType");
    };
	case (typeName []): {
        getText (configFile >> "CfgCurator" >> "waypointInfoType");
	};
	case (typeName ""): {
        getText (configFile >> "CfgCurator" >> "markerInfoType");
	};
	default {""};
};

if (isClass (configFile >> _curatorInfoType)) then {
    private _attributes = [_curator, _entity] call BIS_fnc_curatorAttributes;
    if !(_attributes isEqualTo []) then {
        BIS_fnc_initCuratorAttributes_target = _entity;
        BIS_fnc_initCuratorAttributes_attributes = _attributes;
        createDialog _curatorInfoType;
        true
    };
} else {
    if (_curatorInfoType != "") then {
        ["Display '%1' not found", _curatorInfoType] call BIS_fnc_error;
    };
    false
};
