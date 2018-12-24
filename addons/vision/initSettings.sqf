[
    QGVAR(enableNVG),
    "CHECKBOX",
    LSTRING(EnableNVG),
    [ELSTRING(common,Category), LSTRING(VisionModes)],
    true,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableWhiteHot),
    "CHECKBOX",
    LSTRING(EnableWhiteHot),
    [ELSTRING(common,Category), LSTRING(VisionModes)],
    true,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableBlackHot),
    "CHECKBOX",
    LSTRING(EnableBlackHot),
    [ELSTRING(common,Category), LSTRING(VisionModes)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableGreenHotCold),
    "CHECKBOX",
    LSTRING(EnableGreenHotCold),
    [ELSTRING(common,Category), LSTRING(VisionModes)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableBlackHotGreenCold),
    "CHECKBOX",
    LSTRING(EnableBlackHotGreenCold),
    [ELSTRING(common,Category), LSTRING(VisionModes)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableRedHotCold),
    "CHECKBOX",
    LSTRING(EnableRedHotCold),
    [ELSTRING(common,Category), LSTRING(VisionModes)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableBlackHotRedCold),
    "CHECKBOX",
    LSTRING(EnableBlackHotRedCold),
    [ELSTRING(common,Category), LSTRING(VisionModes)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableWhiteHotRedCold),
    "CHECKBOX",
    LSTRING(EnableWhiteHotRedCold),
    [ELSTRING(common,Category), LSTRING(VisionModes)],
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(enableRedGreenThermal),
    "CHECKBOX",
    LSTRING(EnableRedGreenThermal),
    [ELSTRING(common,Category), LSTRING(VisionModes)],
    false,
    false
] call CBA_settings_fnc_init;
