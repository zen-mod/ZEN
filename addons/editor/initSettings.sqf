[
    QGVAR(moveDisplayToEdge),
    "CHECKBOX",
    [LSTRING(MoveDisplayToEdge), LSTRING(MoveDisplayToEdge_Description)],
    ELSTRING(Common,Category),
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(removeWatermark),
    "CHECKBOX",
    [LSTRING(RemoveWatermark), LSTRING(RemoveWatermark_Description)],
    ELSTRING(Common,Category),
    true,
    false
] call CBA_settings_fnc_init;
