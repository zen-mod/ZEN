[ELSTRING(main,DisplayName), QGVAR(open), [LSTRING(OpenAttributesDisplay), LSTRING(OpenAttributesDisplay_Description)], {
    if (!isNull curatorCamera && {!dialog && {!GETMVAR(RscDisplayCurator_search,false)}}) then {
        scopeName "Main";

        curatorMouseOver params ["_type", "_entity", "_index"];

        if (_type != "") then {
            if (_type == "ARRAY") then {
                _entity = [_entity, _index];
            };

            if (curatorSelected findIf {_entity in _x} != -1) then {
                _entity call BIS_fnc_showCuratorAttributes;
                breakOut "Main";
            };
        };

        {
            private _entity = _x param [0];

            if (!isNil "_entity") exitWith {
                _entity call BIS_fnc_showCuratorAttributes;
            };
        } forEach [SELECTED_GROUPS, SELECTED_OBJECTS, SELECTED_WAYPOINTS, SELECTED_MARKERS];
    };
}, {}, [DIK_GRAVE, [false, false, false]]] call CBA_fnc_addKeybind; // Default: GRAVE
