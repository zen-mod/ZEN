[
    QGVAR(followTerrain),
    "CHECKBOX",
    [LSTRING(FollowTerrain), LSTRING(FollowTerrain_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(adaptiveSpeed),
    "CHECKBOX",
    [LSTRING(AdaptiveSpeed), LSTRING(AdaptiveSpeed_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(defaultSpeedCoef),
    "SLIDER",
    [LSTRING(DefaultSpeedCoef), LSTRING(DefaultSpeedCoef_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [0.1, 5, 1, 2],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(fastSpeedCoef),
    "SLIDER",
    [LSTRING(FastSpeedCoef), LSTRING(FastSpeedCoef_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [0.1, 5, 1, 2],
    false
] call CBA_fnc_addSetting;
