[
    QGVAR(moveDisplayToEdge),
    "CHECKBOX",
    [LSTRING(MoveDisplayToEdge), LSTRING(MoveDisplayToEdge_Description)],
    ELSTRING(common,Category),
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(removeWatermark),
    "CHECKBOX",
    [LSTRING(RemoveWatermark), LSTRING(RemoveWatermark_Description)],
    ELSTRING(common,Category),
    true,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(disableLiveSearch),
    "CHECKBOX",
    [LSTRING(DisableLiveSearch), LSTRING(DisableLiveSearch_Description)],
    ELSTRING(common,Category),
    false,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(declutterEmptyTree),
    "CHECKBOX",
    [LSTRING(DeclutterEmptyTree), LSTRING(DeclutterEmptyTree_Description)],
    ELSTRING(common,Category),
    true,
    false
] call CBA_settings_fnc_init;

[
    QGVAR(unitRadioMessages),
    "LIST",
    [LSTRING(UnitRadioMessages), LSTRING(UnitRadioMessages_Description)],
    ELSTRING(common,Category),
    [[0, 1, 2], [ELSTRING(common,Enabled), LSTRING(UnitRadioMessages_WaypointsOnly), ELSTRING(common,Disabled)], 0],
    false
] call CBA_settings_fnc_init;
