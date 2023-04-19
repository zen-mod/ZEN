[ELSTRING(main,DisplayName), QGVAR(toggleIncludeCrew), LSTRING(ToggleIncludeCrew), {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        GVAR(includeCrew) = !GVAR(includeCrew);

        private _ctrlIncludeCrew = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_INCLUDE_CREW;
        _ctrlIncludeCrew cbSetChecked GVAR(includeCrew);
    };
}, {}, [DIK_B, [false, false, false]]] call CBA_fnc_addKeybind; // Default: B

[ELSTRING(main,DisplayName), QGVAR(unloadViV), ["STR_A3_ModuleDepot_Unload", LSTRING(UnloadViV_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            if (isNull isVehicleCargo _x) then {
                // Not being carried
                if (getVehicleCargo _x isNotEqualTo []) then {
                    _x setVehicleCargo objNull;
                };
            } else {
                // Being carried
                objNull setVehicleCargo _x;
            };
        } forEach SELECTED_OBJECTS;

        true // handled, prevents vanilla eject
    };
}, {}, [DIK_G, [false, false, true]]] call CBA_fnc_addKeybind; // Default: ALT + G

[ELSTRING(main,DisplayName), QGVAR(deepCopy), [LSTRING(DeepCopy), LSTRING(DeepCopy_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        private _position = [nil, false] call EFUNC(common,getPosFromScreen);
        GVAR(clipboard) = [SELECTED_OBJECTS, _position, true] call EFUNC(common,serializeObjects);

        playSound ["RscDisplayCurator_error01", true];

        true // handled, prevents vanilla copy
    };
}, {}, [DIK_C, [true, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + SHIFT + C

[ELSTRING(main,DisplayName), QGVAR(deepPaste), [LSTRING(DeepPaste), LSTRING(DeepPaste_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        private _position = [nil, false] call EFUNC(common,getPosFromScreen);
        [QEGVAR(common,deserializeObjects), [GVAR(clipboard), _position, true, GVAR(randomizeCopyPaste)]] call CBA_fnc_serverEvent;

        playSound ["RscDisplayCurator_error01", true];

        true // handled, prevents vanilla paste
    };
}, {}, [DIK_V, [true, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + SHIFT + V

[ELSTRING(main,DisplayName), QGVAR(focusSearchBar), [LSTRING(FocusSearchBar), LSTRING(FocusSearchBar_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        private _searchIDC = [IDC_RSCDISPLAYCURATOR_CREATE_SEARCH, IDC_SEARCH_CUSTOM] select GVAR(disableLiveSearch);
        private _ctrlSearch = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl _searchIDC;
        ctrlSetFocus _ctrlSearch;
    };
}, {}, [DIK_F, [false, true, true]]] call CBA_fnc_addKeybind; // Default: CTRL + ALT + F

[ELSTRING(main,DisplayName), QGVAR(orientTerrainNormal), ["str_3den_display3den_entitymenu_setatl_text", LSTRING(OrientTerrainNormal_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            if (!isPlayer _x) then {
                [QEGVAR(common,setVectorUp), [_x, surfaceNormal getPos _x], _x] call CBA_fnc_targetEvent;
            };
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [DIK_X, [false, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + X

[ELSTRING(main,DisplayName), QGVAR(toggleEditability), [LSTRING(ToggleEditability), LSTRING(ToggleEditability_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        curatorMouseOver params ["_type", "_entity"];

        private _object = if (_type != "OBJECT") then {
            if (!call EFUNC(common,isCursorOnMouseArea)) exitWith {objNull};

            private _begPos = getPosASL curatorCamera;
            private _endPos = AGLToASL screenToWorld getMousePosition;
            lineIntersectsSurfaces [_begPos, _endPos, curatorCamera] param [0, []] param [2, objNull]
        } else {
            _entity
        };

        if (!isNull _object) then {
            private _curator = getAssignedCuratorLogic player;
            private _isEditable = _object in curatorEditableObjects _curator;
            [_object, !_isEditable, _curator] call EFUNC(common,updateEditableObjects);
        };

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[ELSTRING(main,DisplayName), QGVAR(toggleIcons), [LSTRING(ToggleIcons), LSTRING(ToggleIcons_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        GVAR(iconsVisible) = !GVAR(iconsVisible);

        private _ctrlEntities = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_ENTITIES;

        if (GVAR(iconsVisible)) then {
            tvExpandAll _ctrlEntities;
        } else {
            _ctrlEntities call EFUNC(common,collapseTree);
        };
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[ELSTRING(main,DisplayName), QGVAR(reloadDisplay), [LSTRING(ReloadDisplay), LSTRING(ReloadDisplay_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        [] call EFUNC(common,reloadDisplay);

        true // handled
    };
}, {}, [DIK_R, [true, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + SHIFT + R

[ELSTRING(main,DisplayName), QGVAR(pingCurators), [LSTRING(pingCurators), LSTRING(pingCurators_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        private _thisCurator = getAssignedCuratorLogic player;
        private _object = if (SELECTED_OBJECTS isEqualTo []) then {
            curatorMouseOver param [1, _thisCurator]
        } else {
            SELECTED_OBJECTS select 0
        };
        if (_object == _thisCurator) then {_thisCurator setPosASL ([] call EFUNC(common,getPosFromScreen))};
        [QGVAR(pingCurator), [_object], allCurators] call CBA_fnc_targetEvent;

        true // handled
    };
}, {}, [DIK_U, [false, false, false]]] call CBA_fnc_addKeybind; // Default: U

[[ELSTRING(main,DisplayName), LSTRING(AIControl)], QGVAR(ejectPassengers), [LSTRING(EjectPassengers), LSTRING(EjectPassengers_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            [_x] call EFUNC(common,ejectPassengers);
        } forEach SELECTED_OBJECTS;

        true // handled, prevents vanilla eject
    };
}, {}, [DIK_G, [false, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + G

[[ELSTRING(main,DisplayName), LSTRING(AIControl)], QGVAR(deployCountermeasures), [LSTRING(DeployCountermeasures), LSTRING(DeployCountermeasures_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            [_x] call EFUNC(common,deployCountermeasures);
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [DIK_C, [true, false, false]]] call CBA_fnc_addKeybind; // Default: SHIFT + C

[[ELSTRING(main,DisplayName), LSTRING(AIControl)], QGVAR(watchCursor), [LSTRING(WatchCursor), LSTRING(WatchCursor_Description)], {
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

[[ELSTRING(main,DisplayName), LSTRING(AIControl)], QGVAR(watchCuratorCamera), [LSTRING(WatchCuratorCamera), LSTRING(WatchCuratorCamera_Description)], {
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

[[ELSTRING(main,DisplayName), LSTRING(AIControl)], QGVAR(forceFire), [LSTRING(ForceFire), LSTRING(ForceFire_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        private _units = SELECTED_OBJECTS select {!isPlayer _x && {!isNull group _x}};
        [QEGVAR(common,forceFire), [_units, CBA_clientID]] call CBA_fnc_globalEvent;

        true // handled
    };
}, {
    [QEGVAR(common,forceFire), [[], CBA_clientID]] call CBA_fnc_globalEvent;
}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[[ELSTRING(main,DisplayName), LSTRING(AIControl)], QGVAR(toggleLaser), [LSTRING(ToggleLaser), LSTRING(ToggleLaser_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            if (!isNull group _x && {!isPlayer _x}) then {
                [_x] call EFUNC(common,setVehicleLaserState);
            };
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[[ELSTRING(main,DisplayName), LSTRING(AIControl)], QGVAR(moveToCursor), [LSTRING(MoveToCursor), LSTRING(MoveToCursor_Description)], {
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

[[ELSTRING(main,DisplayName), LSTRING(AIControl)], QGVAR(toggleAIPATH), [LSTRING(ToggleAIPATH), LSTRING(ToggleAIPATH_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            if (!isPlayer _x && {_x == vehicle _x || {_x == driver vehicle _x}}) then {
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
