[
    QGVAR(enabled),
    "LIST",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    ELSTRING(common,Category),
    [[0, 1, 2], [ELSTRING(common,Disabled), LSTRING(KeybindOnly), LSTRING(KeybindAndMouse)], 2],
    false
] call CBA_settings_fnc_init;
