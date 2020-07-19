[ELSTRING(main,DisplayName), QGVAR(open), [LSTRING(OpenAttributesDisplay), LSTRING(OpenAttributesDisplay_Description)], {
    if (!isNull curatorCamera && {!dialog && {!GETMVAR(RscDisplayCurator_search,false)}}) then {
        curatorSelected params ["_objects", "_groups", "_waypoints", "_markers"];

        private _entity = switch (true) do {
            case !(isNull GVAR(selectedGroup)): {GVAR(selectedGroup)};
            case !(_objects isEqualTo []): {_objects select 0};
            case !(_markers isEqualTo []): {_markers select 0};
            case !(_waypoints isEqualTo []): {_waypoints select 0};
            default { nil };
        };

        if !(isNil "_entity") then {
            _entity call BIS_fnc_showCuratorAttributes;
        };
    };
}, {}, [DIK_GRAVE, [false, false, false]]] call CBA_fnc_addKeybind; // Default: GRAVE
