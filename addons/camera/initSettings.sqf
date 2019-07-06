[
    QGVAR(followTerrain),
    "CHECKBOX",
    [LSTRING(FollowTerrain), LSTRING(FollowTerrain_Description)],
    [ELSTRING(common,Category), LSTRING(Camera)],
    true,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(adaptiveSpeed),
    "CHECKBOX",
    [LSTRING(AdaptiveSpeed), LSTRING(AdaptiveSpeed_Description)],
    [ELSTRING(common,Category), LSTRING(Camera)],
    true,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(defaultSpeedCoef),
    "SLIDER",
    [LSTRING(DefaultSpeedCoef), LSTRING(DefaultSpeedCoef_Description)],
    [ELSTRING(common,Category), LSTRING(Camera)],
    [1, 5, 1, 2],
    false
] call CBA_settings_fnc_init;

[
    QGVAR(fastSpeedCoef),
    "SLIDER",
    [LSTRING(FastSpeedCoef), LSTRING(FastSpeedCoef_Description)],
    [ELSTRING(common,Category), LSTRING(Camera)],
    [1, 5, 1, 2],
    false
] call CBA_settings_fnc_init;
