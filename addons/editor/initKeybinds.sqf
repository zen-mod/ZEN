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
