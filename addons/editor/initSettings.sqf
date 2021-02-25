[
    QGVAR(moveDisplayToEdge),
    "CHECKBOX",
    [LSTRING(MoveDisplayToEdge), LSTRING(MoveDisplayToEdge_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(removeWatermark),
    "CHECKBOX",
    [LSTRING(RemoveWatermark), LSTRING(RemoveWatermark_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(disableLiveSearch),
    "CHECKBOX",
    [LSTRING(DisableLiveSearch), LSTRING(DisableLiveSearch_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(declutterEmptyTree),
    "CHECKBOX",
    [LSTRING(DeclutterEmptyTree), LSTRING(DeclutterEmptyTree_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(addGroupIcons),
    "CHECKBOX",
    [LSTRING(AddGroupIcons), LSTRING(AddGroupIcons_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(randomizeCopyPaste),
    "CHECKBOX",
    [LSTRING(RandomizeCopyPaste), LSTRING(RandomizeCopyPaste_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    false,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(deepPasteHC),
    "CHECKBOX",
    [LSTRING(DeepPasteHC), LSTRING(DeepPasteHC_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(unitRadioMessages),
    "LIST",
    [LSTRING(UnitRadioMessages), LSTRING(UnitRadioMessages_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [[0, 1, 2], [ELSTRING(common,Enabled), LSTRING(UnitRadioMessages_WaypointsOnly), ELSTRING(common,Disabled)], 0],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(parachuteSounds),
    "CHECKBOX",
    [LSTRING(ParachuteSounds), LSTRING(ParachuteSounds_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    true
] call CBA_fnc_addSetting;
