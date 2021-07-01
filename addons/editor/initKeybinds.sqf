[ELSTRING(main,DisplayName), QGVAR(toggleIncludeCrew), LSTRING(ToggleIncludeCrew), {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        GVAR(includeCrew) = !GVAR(includeCrew);

        private _ctrlIncludeCrew = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_INCLUDE_CREW;
        _ctrlIncludeCrew cbSetChecked GVAR(includeCrew);
    };
}, {}, [DIK_B, [false, false, false]]] call CBA_fnc_addKeybind; // Default: B

[ELSTRING(main,DisplayName), QGVAR(deployCountermeasures), [LSTRING(DeployCountermeasures), LSTRING(DeployCountermeasures_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            [_x] call EFUNC(common,deployCountermeasures);
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [DIK_C, [true, false, false]]] call CBA_fnc_addKeybind; // Default: SHIFT + C

[ELSTRING(main,DisplayName), QGVAR(ejectPassengers), [LSTRING(EjectPassengers), LSTRING(EjectPassengers_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            [_x] call EFUNC(common,ejectPassengers);
        } forEach SELECTED_OBJECTS;

        true // handled, prevents vanilla eject
    };
}, {}, [DIK_G, [false, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + G

[ELSTRING(main,DisplayName), QGVAR(unloadViV), [localize "STR_A3_ModuleDepot_Unload", LSTRING(UnloadViV_Description)], {
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
        findDisplay IDD_RSCDISPLAYCURATOR closeDisplay IDC_CANCEL;

        {openCuratorInterface} call CBA_fnc_execNextFrame;

        true // handled
    };
}, {}, [DIK_R, [true, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + SHIFT + R

[ELSTRING(main,DisplayName), QGVAR(watchCuratorCamera), [LSTRING(WatchCuratorCamera), LSTRING(WatchCuratorCamera_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false) && {count SELECTED_OBJECTS > 0}}) then {
        private _pos = getPos curatorCamera;
        {
            if (!isNull group _x && {!isPlayer _x}) then {
                [QEGVAR(common,doWatch), [_x, _pos], _x] call CBA_fnc_targetEvent;
                [2, [_x, _pos, []]] call EFUNC(common,hintAddElement);
                [2, ["\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\scout_ca.paa", [], _pos, 1, 1, 0]] call EFUNC(common,hintAddElement);
            };
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[ELSTRING(main,DisplayName), QGVAR(watchCursor), [LSTRING(WatchCursor), LSTRING(WatchCursor_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false) && {count SELECTED_OBJECTS > 0}}) then {
        curatorMouseOver params ["_type", "_entity"];
        private _isCancelling = _type == "OBJECT" && {_entity in SELECTED_OBJECTS};
        private _cursorPosASL = [] call EFUNC(common,getPosFromScreen);
        {
            if (!isNull group _x && {!isPlayer _x}) then {
                [QEGVAR(common,doWatch), [_x, [ASLToAGL _cursorPosASL, objNull] select _isCancelling], _x] call CBA_fnc_targetEvent;
                [2, [_x, ASLToAGL _cursorPosASL, []]] call EFUNC(common,hintAddElement);
                [2, ["\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\scout_ca.paa", [], ASLToAGL _cursorPosASL, 1, 1, 0]] call EFUNC(common,hintAddElement);
            };
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[ELSTRING(main,DisplayName), QGVAR(forceFire), [LSTRING(ForceFire), LSTRING(ForceFire_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false) && {count SELECTED_OBJECTS > 0}}) then {
        private _shooters = SELECTED_OBJECTS select {!isNull group _x && {!isPlayer _x}};
        [QEGVAR(common,ForceFire), [clientOwner, _shooters], _shooters] call CBA_fnc_targetEvent;

        true // handled
    };
}, {
    [QEGVAR(common,ForceFire), [clientOwner, []]] call CBA_fnc_globalEvent;
}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[ELSTRING(main,DisplayName), QGVAR(moveToCursor), [LSTRING(MoveToCursor), LSTRING(MoveToCursor_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        private _cursorPosASL = [] call EFUNC(common,getPosFromScreen);

        {
            if (!isNull driver _x && {!isPlayer _x}) then {
                [QEGVAR(common,doMove), [_x, ASLToAGL _cursorPosASL], _x] call CBA_fnc_targetEvent;
                [2, [_x, ASLToAGL _cursorPosASL, []]] call EFUNC(common,hintAddElement);
                [2, ["\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\walk_ca.paa", [], ASLToAGL _cursorPosASL, 1, 1, 0]] call EFUNC(common,hintAddElement);
            };
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[ELSTRING(main,DisplayName), QGVAR(toggleAIPATH), [LSTRING(ToggleAIPATH), LSTRING(ToggleAIPATH_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false) && {SELECTED_OBJECTS isNotEqualTo []}}) then {
        private _disabled = 0;
        private _enabled = 0;

        {
            if (_x == driver vehicle _x && {!isPlayer _x}) then {
                private _isAIEnabledPATH = _x checkAIFeature "PATH";
                private _AIEvent = [QEGVAR(common,enableAI), QEGVAR(common,disableAI)] select _isAIEnabledPATH;
                [_AIEvent, [_x, "PATH"], _x] call CBA_fnc_globalEvent;
                if (_isAIEnabledPATH) then {
                    _disabled = _disabled + 1;
                } else {
                    _enabled = _enabled + 1;
                };
            };
        } forEach SELECTED_OBJECTS;

        [
            "%1 %2%3",
            localize LSTRING(ToggleAIPATH),
            if (_disabled > 0) then {
                format [" - %1: %2", localize ELSTRING(common,Disabled), _disabled]
            } else {
                ""
            },
            if (_enabled > 0) then {
                format [" - %1: %2", localize ELSTRING(common,Enabled), _enabled]
            } else {
                ""
            }
        ] call EFUNC(common,showMessage);

        true // handled
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound
