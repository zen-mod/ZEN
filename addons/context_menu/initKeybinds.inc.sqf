[ELSTRING(main,DisplayName), QGVAR(openKey), LSTRING(OpenContextMenu), {
    if (GVAR(enabled) > 0 && {!isNull curatorCamera} && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        // Cancel currently active placement
        if (call EFUNC(common,isPlacementActive)) then {
            call EFUNC(common,getActiveTree) tvSetCurSel [-1];
        };

        [] call FUNC(open);
    };
}, {}, [DIK_V, [false, false, false]]] call CBA_fnc_addKeybind; // Default: V
