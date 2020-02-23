[
    QGVAR(hideModules),
    "CHECKBOX",
    [LSTRING(HideModules), LSTRING(HideModules_Description)],
    [ELSTRING(common,Category), LSTRING(DisplayName)],
    true,
    false
] call CBA_settings_fnc_init;
