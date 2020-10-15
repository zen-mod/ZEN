[
    QGVAR(enabled),
    "LIST",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    ELSTRING(main,DisplayName),
    [[0, 1, 2], [ELSTRING(common,Disabled), LSTRING(KeybindOnly), LSTRING(KeybindAndMouse)], 2],
    false
] call CBA_fnc_addSetting;
