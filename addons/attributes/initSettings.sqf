[
    QGVAR(enableRank),
    "CHECKBOX",
    ["str_3den_object_attribute_rank_displayname", LSTRING(EnableAttribute_Description)],
    [ELSTRING(main,DisplayName), "str_3den_display3den_menubar_attributes_text"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableVehicleLock),
    "CHECKBOX",
    ["str_3den_object_attribute_lock_displayname", LSTRING(EnableAttribute_Description)],
    [ELSTRING(main,DisplayName), "str_3den_display3den_menubar_attributes_text"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableRespawn),
    "CHECKBOX",
    ["str_3den_multiplayer_attributecategory_respawn_displayname", LSTRING(EnableAttribute_Description)],
    [ELSTRING(main,DisplayName), "str_3den_display3den_menubar_attributes_text"],
    true,
    false
] call CBA_fnc_addSetting;
