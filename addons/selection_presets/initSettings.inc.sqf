[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(emptySlotMode),
    "LIST",
    [LSTRING(EmptySlotMode), LSTRING(EmptySlotMode_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [
        [
            EMPTY_SLOT_MODE_SHOW_ALL,
            EMPTY_SLOT_MODE_HIDE_EMPTY_SLOTS,
            EMPTY_SLOT_MODE_REPLACE_WITH_ADD_BUTTON
        ],
        [
            [LSTRING(ShowAll), LSTRING(ShowAll_Description)],
            [LSTRING(HideEmptySlots), LSTRING(HideEmptySlots_Description)],
            [LSTRING(ReplaceWithAddButton), LSTRING(ReplaceWithAddButton_Description)]
        ],
        2
    ],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(useGroupIcons),
    "LIST",
    [LSTRING(UseGroupIcons), LSTRING(UseGroupIcons_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [
        [
            USE_GROUP_ICONS_NO,
            USE_GROUP_ICONS_YES,
            USE_GROUP_ICONS_EXCEPT_SINGLE_UNITS
        ],
        [
            ELSTRING(common,No),
            ELSTRING(common,Yes),
            [LSTRING(ExceptSingleUnits), LSTRING(ExceptSingleUnits_Description)]
        ],
        1
    ],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(showTooltips),
    "CHECKBOX",
    [LSTRING(ShowTooltips), LSTRING(ShowTooltips_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(persistPresets),
    "CHECKBOX",
    [LSTRING(PersistPresets), LSTRING(PersistPresets_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(excludeFromPresets),
    "LIST",
    [LSTRING(ExcludeFromPresets), LSTRING(ExcludeFromPresets_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [
        [
            EXCLUDE_FROM_PRESETS_NONE,
            EXCLUDE_FROM_PRESETS_PROPS,
            EXCLUDE_FROM_PRESETS_MODULES,
            EXCLUDE_FROM_PRESETS_PROPS_AND_MODULES
        ],
        [
            "STR_A3_None",
            "STR_3DEN_Object_Mode_Empty",
            "STR_3DEN_Logic_Mode_Module",
            LSTRING(PropsAndModules)
        ],
        0
    ],
    false
] call CBA_fnc_addSetting;
