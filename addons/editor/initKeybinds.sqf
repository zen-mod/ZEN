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

        private _ctrlEntites = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_ENTITIES;

        if (GVAR(iconsVisible)) then {
            tvExpandAll _ctrlEntites;
        } else {
            _ctrlEntites call EFUNC(common,collapseTree);
        };
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[ELSTRING(main,DisplayName), QGVAR(watchCursor), [LSTRING(WatchCursor), LSTRING(WatchCursor_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        curatorMouseOver params ["_type", "_entity", ""];
        private _isCancelling = _type == "OBJECT" && {_entity in SELECTED_OBJECTS};
        private _gunners = (SELECTED_OBJECTS apply {gunner vehicle _x}) - [objNull];

        private _cursorPosASL = call EFUNC(common,getCursorPosition);
        {
            [QEGVAR(common,doWatch), [_x, [ASLToAGL _cursorPosASL, objNull] select _isCancelling], _x] call CBA_fnc_targetEvent;
        } forEach _gunners;

        true // handled, prevents vanilla eject
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[ELSTRING(main,DisplayName), QGVAR(moveToCursor), [LSTRING(MoveToCursor), LSTRING(MoveToCursor_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        private _cursorPosASL = call EFUNC(common,getCursorPosition);

        {
            if (!isNull driver _x) then {
                [QEGVAR(common,doMove), [_x, ASLToAGL _cursorPosASL], _x] call CBA_fnc_targetEvent;
            };
        } forEach SELECTED_OBJECTS;

        true // handled, prevents vanilla eject
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound

[ELSTRING(main,DisplayName), QGVAR(toggleAIPATH), [LSTRING(ToggleAIPATH), LSTRING(ToggleAIPATH_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false) && {count SELECTED_OBJECTS > 0}}) then {
        private _disabled = 0;
        private _enabled = 0;
        private _drivers = (SELECTED_OBJECTS apply {driver vehicle _x}) - [objNull];
        _drivers = _drivers arrayIntersect _drivers;

        {
            private _isAIEnabledPATH = _x getVariable [QEGVAR(common,isAIEnabledPATH), true];
            private _AIEvent = [QEGVAR(common,enableAI), QEGVAR(common,disableAI)] select _isAIEnabledPATH;
            [_AIEvent, [_x, "PATH"], _x] call CBA_fnc_targetEvent;
            _x setVariable [QEGVAR(common,isAIEnabledPATH), !_isAIEnabledPATH, true];
            if (_isAIEnabledPATH) then {
                _disabled = _disabled + 1;
            } else {
                _enabled = _enabled + 1;
            };
        } forEach _drivers;

        private _message = "PATH " +
            (["", format [" - %1: %2", localize ELSTRING(common,Disabled), _disabled]] select (_disabled > 0)) +
            (["", format [" - %1: %2", localize ELSTRING(common,Enabled), _enabled]] select (_enabled > 0));
        [_message] call EFUNC(common,showMessage);

        true // handled, prevents vanilla eject
    };
}, {}, [0, [false, false, false]]] call CBA_fnc_addKeybind; // Default: Unbound
