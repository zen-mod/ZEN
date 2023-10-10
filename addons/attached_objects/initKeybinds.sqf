[[ELSTRING(main,DisplayName), LSTRING(DisplayName)], QGVAR(attach), [LSTRING(Attach), LSTRING(Attach_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        SELECTED_OBJECTS call FUNC(attach);
        true // handled
    };
}, {}, [DIK_A, [true, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + SHIFT + A

[[ELSTRING(main,DisplayName), LSTRING(DisplayName)], QGVAR(attachBone), [LSTRING(AttachBone), LSTRING(AttachBone_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        SELECTED_OBJECTS call FUNC(attachBone);
        true // handled
    };
}, {}, []] call CBA_fnc_addKeybind; // Default: Unbound

[[ELSTRING(main,DisplayName), LSTRING(DisplayName)], QGVAR(detach), [LSTRING(Detach), LSTRING(Detach_Description)], {
    if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
        SELECTED_OBJECTS call FUNC(detach);
        true // handled
    };
}, {}, [DIK_D, [true, true, false]]] call CBA_fnc_addKeybind; // Default: CTRL + SHIFT + D
