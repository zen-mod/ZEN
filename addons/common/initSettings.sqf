[
    QGVAR(autoAddObjects),
    "CHECKBOX",
    [LSTRING(AutoAddObjects), LSTRING(AutoAddObjects_Description)],
    LSTRING(Category),
    false,
    true
] call CBA_settings_fnc_init;

[
    QGVAR(disableGearAnim),
    "CHECKBOX",
    [LSTRING(DisableGearAnim), LSTRING(DisableGearAnim_Description)],
    LSTRING(Category),
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(darkMode),
    "CHECKBOX",
    [LSTRING(DarkMode), LSTRING(DarkMode_Description)],
    LSTRING(Category),
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(preferredArsenal),
    "LIST",
    [LSTRING(PreferredArsenal), LSTRING(PreferredArsenal_Description)],
    LSTRING(Category),
    [[0, 1], [LSTRING(BIVirtualArsenal), LSTRING(AceArsenal)], 1],
    false
] call CBA_settings_fnc_init;
