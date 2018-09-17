[ELSTRING(common,Category), QGVAR(openKey), LSTRING(OpenContextMenu), {
    if (GVAR(enabled) > 0 && {!isNull curatorCamera}) then {
        call FUNC(openMenu);
    };
}, {}, [DIK_V, [false, false, false]]] call CBA_fnc_addKeybind; // Default: V
