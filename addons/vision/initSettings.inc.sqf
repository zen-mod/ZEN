[
    QGVAR(enableNVG),
    "CHECKBOX",
    LSTRING(EnableNVG),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableWhiteHot),
    "CHECKBOX",
    LSTRING(EnableWhiteHot),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableBlackHot),
    "CHECKBOX",
    LSTRING(EnableBlackHot),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableGreenHotCold),
    "CHECKBOX",
    LSTRING(EnableGreenHotCold),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableBlackHotGreenCold),
    "CHECKBOX",
    LSTRING(EnableBlackHotGreenCold),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableRedHotCold),
    "CHECKBOX",
    LSTRING(EnableRedHotCold),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableBlackHotRedCold),
    "CHECKBOX",
    LSTRING(EnableBlackHotRedCold),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableWhiteHotRedCold),
    "CHECKBOX",
    LSTRING(EnableWhiteHotRedCold),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableRedGreenThermal),
    "CHECKBOX",
    LSTRING(EnableRedGreenThermal),
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;
