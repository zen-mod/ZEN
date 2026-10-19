[ELSTRING(main,DisplayName), QGVAR(toggle), [LSTRING(Toggle), LSTRING(Toggle_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        GVAR(state) = !GVAR(state);
        GVAR(state) call FUNC(toggle);

        true // handled
    };
}, {}, [DIK_L, [false, false, false]]] call CBA_fnc_addKeybind; // Default: L
