[
    QGVAR(autoAddObjects),
    "CHECKBOX",
    [LSTRING(AutoAddObjects), LSTRING(AutoAddObjects_Description)],
    LSTRING(Category),
    false,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(preferredArsenal),
    "LIST",
    [LSTRING(PreferredArsenal), LSTRING(PreferredArsenal_Description)],
    LSTRING(Category),
    [[0, 1], [LSTRING(BIVirtualArsenal), LSTRING(AceArsenal)], 1],
    false
] call CBA_settings_fnc_init;
