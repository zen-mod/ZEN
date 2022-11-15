[[ELSTRING(main,DisplayName), LSTRING(DisplayName)], QGVAR(attach), [LSTRING(Attach), LSTRING(Attach_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        SELECTED_OBJECTS call FUNC(attach);
        true // handled
    };
}, {}, [DIK_A, [true, false, true]]] call CBA_fnc_addKeybind; // Default: SHIFT + ALT + A

[[ELSTRING(main,DisplayName), LSTRING(DisplayName)], QGVAR(detach), [LSTRING(Detach), LSTRING(Detach_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        SELECTED_OBJECTS call FUNC(detach);
        true // handled
    };
}, {}, [DIK_D, [true, false, true]]] call CBA_fnc_addKeybind; // Default: SHIFT + ALT + D
