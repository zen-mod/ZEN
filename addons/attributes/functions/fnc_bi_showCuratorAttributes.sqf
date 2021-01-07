#include "script_component.hpp"
/*
 * Author: Bohemia Interactive, mharis001
 * Shows the Zeus attribute display for an entity.
 * Edited for compatibility with the ZEN attributes framework.
 *
 * Arguments:
 * 0: Entity <OBJECT|GROUP|ARRAY|STRING>
 *
 * Return Value:
 * Display Opened <BOOL>
 *
 * Example:
 * [_object] call BIS_fnc_showCuratorAttributes
 *
 * Public: No
 */

// Prevent attributes from opening if remote controlling (cannot override double click EH)
if (!isNull (missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", objNull])) exitWith {false};

// Need [_this] for passed waypoint arrays
[_this] params [["_entity", objNull, [objNull, grpNull, [], ""]]];

scopeName "Main";

if (_entity isEqualType objNull) then {
    // Exit if opening attributes is disabled for this object
    if (_entity getVariable [QGVAR(disabled), false]) then {
        false breakOut "Main";
    };

    private _infoTypeClass = ["curatorInfoType", "curatorInfoTypeEmpty"] select (isNull group _entity && {side _entity != sideLogic});
    private _infoType = getText (configOf _entity >> _infoTypeClass);

    // Use info type instead of ZEN attributes if it is defined
    if (isClass (configFile >> _infoType)) then {
        private _curator = getAssignedCuratorLogic player;
        private _attributes = [_curator, _entity] call BIS_fnc_curatorAttributes;

        if (_attributes isEqualTo []) then {
            false breakOut "Main";
        };

        BIS_fnc_initCuratorAttributes_target = _entity;
        BIS_fnc_initCuratorAttributes_attributes = _attributes;
        (createDialog _infoType) breakOut "Main";
    };
};

// Exit if opening attributes is disabled for this group or if it is a logic side group
if (_entity isEqualType grpNull && {_entity getVariable [QGVAR(disabled), false] || {side _entity == sideLogic}}) exitWith {false};

private _type = switch (true) do {
    case (_entity isEqualType objNull): {"Object"};
    case (_entity isEqualType grpNull): {"Group"};
    case (_entity isEqualType []): {"Waypoint"};
    case (_entity isEqualType ""): {"Marker"};
};

[_entity, _type] call FUNC(open);

true
