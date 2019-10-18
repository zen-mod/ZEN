[ELSTRING(common,Category), QGVAR(toggleIncludeCrew), LSTRING(ToggleIncludeCrew), {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        GVAR(includeCrew) = !GVAR(includeCrew);
        (findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_INCLUDE_CREW) cbSetChecked GVAR(includeCrew);
    };
}, {}, [DIK_B, [false, false, false]]] call CBA_fnc_addKeybind; // Default: B

[ELSTRING(common,Category), QGVAR(deployCountermeasures), [LSTRING(DeployCountermeasures), LSTRING(DeployCountermeasures_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            [_x] call EFUNC(common,deployCountermeasures);
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [DIK_C, [true, false, false]]] call CBA_fnc_addKeybind; // Default: SHIFT + C

[ELSTRING(common,Category), QGVAR(ejectPassengers), [LSTRING(EjectPassengers), LSTRING(EjectPassengers_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            [_x] call EFUNC(common,ejectPassengers);
        } forEach SELECTED_OBJECTS;

        true // handled, prevents vanilla eject
    };
}, {}, [DIK_G, [false, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + G

[ELSTRING(common,Category), QGVAR(deepCopy), [LSTRING(DeepCopy), LSTRING(DeepCopy_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        GVAR(clipboard) = [SELECTED_OBJECTS] call FUNC(deepCopy);
        playSound ["RscDisplayCurator_error01", true];

        true // handled, prevents vanilla copy
    };
}, {}, [DIK_C, [true, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + SHIFT + C

[ELSTRING(common,Category), QGVAR(deepPaste), [LSTRING(DeepPaste), LSTRING(DeepPaste_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        [QGVAR(deepPaste), GVAR(clipboard)] call CBA_fnc_serverEvent;
        playSound ["RscDisplayCurator_error01", true];

        true // handled, prevents vanilla paste
    };
}, {}, [DIK_V, [true, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + SHIFT + V
