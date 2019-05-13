[ELSTRING(common,Category), QGVAR(toggleIncludeCrew), LSTRING(ToggleIncludeCrew), {
    if (!isNull curatorCamera) then {
        GVAR(includeCrew) = !GVAR(includeCrew);
        (findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_INCLUDE_CREW) cbSetChecked GVAR(includeCrew);
    };
}, {}, [DIK_B, [false, false, false]]] call CBA_fnc_addKeybind; // Default: B
