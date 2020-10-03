[
    QGVAR(enabled),
    "LIST",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [[0, 1, 2], [ELSTRING(common,Disabled), LSTRING(KeybindOnly), LSTRING(KeybindAndMouse)], 2],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(overrideWaypoints),
    "CHECKBOX",
    [LSTRING(OverrideWaypoints), LSTRING(OverrideWaypoints_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;
