[ELSTRING(common,Category), QGVAR(toggleIncludeCrew), LSTRING(ToggleIncludeCrew), {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        GVAR(includeCrew) = !GVAR(includeCrew);
        (findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_INCLUDE_CREW) cbSetChecked GVAR(includeCrew);
    };
}, {}, [DIK_B, [false, false, false]]] call CBA_fnc_addKeybind; // Default: B

[ELSTRING(common,Category), QGVAR(ejectPassengers), [LSTRING(EjectPassengers), LSTRING(EjectPassengers_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            [_x] call EFUNC(common,ejectPassengers);
        } forEach SELECTED_OBJECTS;

        true // handled, prevents vanilla eject from activating
    };
}, {}, [DIK_G, [false, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + G

[ELSTRING(common,Category), QGVAR(deployCountermeasures), LSTRING(DeployCountermeasures), {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        {
            [_x] call EFUNC(common,deployCountermeasures);
        } forEach SELECTED_OBJECTS;

        true // handled
    };
}, {}, [DIK_C, [false, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + C
