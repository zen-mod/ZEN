[ELSTRING(common,Category), QGVAR(openKey), LSTRING(Keybind), {
    if (GVAR(enabled) && {!isNull curatorCamera}) then {
        call FUNC(openMenu);
    };
}, {}, [DIK_V, [false, false, false]]] call CBA_fnc_addKeybind; // Default: V
