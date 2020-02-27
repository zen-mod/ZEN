[
    QGVAR(enableNVG),
    "CHECKBOX",
    LSTRING(EnableNVG),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableWhiteHot),
    "CHECKBOX",
    LSTRING(EnableWhiteHot),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableBlackHot),
    "CHECKBOX",
    LSTRING(EnableBlackHot),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableGreenHotCold),
    "CHECKBOX",
    LSTRING(EnableGreenHotCold),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableBlackHotGreenCold),
    "CHECKBOX",
    LSTRING(EnableBlackHotGreenCold),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableRedHotCold),
    "CHECKBOX",
    LSTRING(EnableRedHotCold),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableBlackHotRedCold),
    "CHECKBOX",
    LSTRING(EnableBlackHotRedCold),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableWhiteHotRedCold),
    "CHECKBOX",
    LSTRING(EnableWhiteHotRedCold),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableRedGreenThermal),
    "CHECKBOX",
    LSTRING(EnableRedGreenThermal),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_settings_fnc_init;
