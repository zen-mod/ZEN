private _category = [ELSTRING(main,DisplayName), LSTRING(AIControl)];

[_category, QGVAR(ejectPassengers), [LSTRING(EjectPassengers), LSTRING(EjectPassengers_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            [_x] call EFUNC(common,ejectPassengers);
        } forEach SELECTED_OBJECTS;

        true // handled, prevents vanilla eject
    };
}, {}, [DIK_G, [false, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + G

[_category, QGVAR(deployCountermeasures), [LSTRING(DeployCountermeasures), LSTRING(DeployCountermeasures_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            [_x] call EFUNC(common,deployCountermeasures);
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [DIK_C, [true, false, false]]] call CBA_fnc_addKeybind; // Default: SHIFT + C

[_category, QGVAR(watchCursor), [LSTRING(WatchCursor), LSTRING(WatchCursor_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        curatorMouseOver params ["_type", "_target"];

        if (_type != "OBJECT") then {
            _target = ASLToAGL ([] call EFUNC(common,getPosFromScreen));
        };

        {
            if (!isNull group _x && {!isPlayer _x}) then {
                // Cancel if target is self
                private _isSelf = _x isEqualTo _target;
                private _target = [_target, objNull] select _isSelf;
                [_x, _target] call EFUNC(common,forceWatch);
                if (_isSelf) then {continue};

                [[
                    ["ICON", [_target, "\a3\ui_f\data\igui\cfg\simpletasks\types\scout_ca.paa"]],
                    ["LINE", [_x, _target]]
                ], 3, _x] call EFUNC(common,drawHint);
            };
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[_category, QGVAR(watchCuratorCamera), [LSTRING(WatchCuratorCamera), LSTRING(WatchCuratorCamera_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        private _position = ASLToAGL getPosASL curatorCamera;

        {
            if (!isNull group _x && {!isPlayer _x}) then {
                [_x, _position] call EFUNC(common,forceWatch);

                [[
                    ["ICON", [_position, "\a3\ui_f\data\igui\cfg\simpletasks\types\scout_ca.paa"]],
                    ["LINE", [_x, _position]]
                ], 3, _x] call EFUNC(common,drawHint);
            };
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[_category, QGVAR(forceFire), [LSTRING(ForceFire), LSTRING(ForceFire_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        private _units = SELECTED_OBJECTS select {!isPlayer _x && {!isNull group _x}};
        [QEGVAR(common,forceFire), [_units, CBA_clientID]] call CBA_fnc_globalEvent;

        true // handled
    };
}, {
    [QEGVAR(common,forceFire), [[], CBA_clientID]] call CBA_fnc_globalEvent;
}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[_category, QGVAR(toggleLaser), [LSTRING(ToggleLaser), LSTRING(ToggleLaser_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            if (!isNull group _x && {!isPlayer _x}) then {
                [_x] call EFUNC(common,setVehicleLaserState);
            };
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[_category, QGVAR(moveToCursor), [LSTRING(MoveToCursor), LSTRING(MoveToCursor_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        private _position = ASLToAGL ([] call EFUNC(common,getPosFromScreen));

        {
            if (!isNull driver _x && {!isPlayer _x}) then {
                [QEGVAR(common,doMove), [_x, _position], _x] call CBA_fnc_targetEvent;

                [[
                    ["ICON", [_position, "\a3\ui_f\data\igui\cfg\simpletasks\types\walk_ca.paa"]],
                    ["LINE", [_x, _position]]
                ], 3, _x] call EFUNC(common,drawHint);
            };
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[_category, QGVAR(toggleAIPATH), [LSTRING(ToggleAIPATH), LSTRING(ToggleAIPATH_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            if (!isPlayer _x && {isNull objectParent _x || {_x == driver vehicle _x}}) then {
                private _isPathEnabled = _x checkAIFeature "PATH";
                private _eventName = [QEGVAR(common,enableAI), QEGVAR(common,disableAI)] select _isPathEnabled;
                [_eventName, [_x, "PATH"], _x] call CBA_fnc_globalEvent;

                private _icon = [
                    "\a3\3den\Data\Displays\Display3DEN\PanelRight\modeWaypoints_ca.paa",
                    "\a3\3den\Data\CfgWaypoints\hold_ca.paa"
                ] select _isPathEnabled;

                [[
                    ["ICON", [_x, _icon]]
                ], 3, _x] call EFUNC(common,drawHint);
            };
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[_category, QGVAR(setUnitPosUp), [LSTRING(SetUnitPosUp), LSTRING(SetUnitPosUp_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        [SELECTED_OBJECTS, "UP"] call FUNC(switchStance);

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[_category, QGVAR(setUnitPosMiddle), [LSTRING(SetUnitPosMiddle), LSTRING(SetUnitPosMiddle_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        [SELECTED_OBJECTS, "MIDDLE"] call FUNC(switchStance);

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[_category, QGVAR(setUnitPosDown), [LSTRING(SetUnitPosDown), LSTRING(SetUnitPosDown_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        [SELECTED_OBJECTS, "DOWN"] call FUNC(switchStance);

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[_category, QGVAR(setUnitPosAuto), [LSTRING(SetUnitPosAuto), LSTRING(SetUnitPosAuto_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        [SELECTED_OBJECTS, "AUTO"] call FUNC(switchStance);

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound
