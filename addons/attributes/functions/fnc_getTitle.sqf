#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns an appropriate attributes title for the given entity.
 *
 * Arguments:
 * 0: Entity <OBJECT|GROUP|ARRAY|STRING>
 *
 * Return Value:
 * Title <STRING>
 *
 * Example:
 * [player] call zen_attributes_fnc_getTitle
 *
 * Public: No
 */

params ["_entity", "_type"];

private _entityText = switch (true) do {
    case (_entity isEqualType objNull): {
        getText (configFile >> "CfgVehicles" >> typeOf _entity >> "displayName");
    };
    case (_entity isEqualType grpNull): {
        groupId _entity;
    };
    case (_entity isEqualType []): {
        _entity params ["_group", "_waypointID"];
        format ["%1: %2 #%3", _group, localize "str_a3_cfgmarkers_waypoint_0", _waypointID];
    };
    case (_entity isEqualType ""): {
        private _text = markerText _entity;

        if (_text == "") then {
            _text = localize "str_cfg_markers_marker";
        };

        _text
    };
};

private _title = GVAR(titles) getVariable _type;

if (isNil "_title") then {
    _title = localize "str_a3_rscdisplayattributes_title";
};

toUpper format [_title, _entityText]
