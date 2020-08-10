[ELSTRING(main,DisplayName), QGVAR(open), [LSTRING(OpenAttributesDisplay), LSTRING(OpenAttributesDisplay_Description)], {
    if (!isNull curatorCamera && {!dialog && {!GETMVAR(RscDisplayCurator_search,false)}}) then {
        curatorSelected params ["_objects", "_groups", "_waypoints", "_markers"];

        private _mouseOver = if (count curatorMouseOver > 1) then {
            curatorMouseOver params ["_type", "_entity", ["_waypoint", -1]];
            switch (true) do {
                case ([_entity, _waypoint] in _waypoints): {
                    [_entity, _waypoint]
                };
                case (_entity in _objects);
                case (_entity in _groups);
                case (_entity in _markers): {_entity};
                default {nil};
            };
        };
        if (!isNil "_mouseOver") exitWith {
            _mouseOver call BIS_fnc_showCuratorAttributes;
        };

        private _entity = switch (true) do {
            case (!(_groups isEqualTo []) && {!(isNull GVAR(selectedGroup))}): {
                GVAR(selectedGroup)
            };
            case !(_objects isEqualTo []): {_objects select 0};
            case !(_waypoints isEqualTo []): {_waypoints select 0};
            case !(_markers isEqualTo []): {_markers select 0};
            default { nil };
        };
        if !(isNil "_entity") then {
            _entity call BIS_fnc_showCuratorAttributes;
        };
    };
}, {}, [DIK_GRAVE, [false, false, false]]] call CBA_fnc_addKeybind; // Default: GRAVE
