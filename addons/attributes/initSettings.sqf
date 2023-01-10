[
    QGVAR(enableVehicleLock),
    "CHECKBOX",
    [LSTRING(EnableVehicleLock), LSTRING(EnableVehicleLock_Description)],
    [ELSTRING(main,DisplayName), "str_3den_display3den_menubar_attributes_text"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableRespawn),
    "CHECKBOX",
    [LSTRING(EnableRespawn), LSTRING(EnableRespawn_Description)],
    [ELSTRING(main,DisplayName), "str_3den_display3den_menubar_attributes_text"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enableSpeedLimit),
    "CHECKBOX",
    [LSTRING(EnableSpeedLimit), LSTRING(EnableSpeedLimit_Description)],
    [ELSTRING(main,DisplayName), "str_3den_display3den_menubar_attributes_text"],
    false,
    false
] call CBA_fnc_addSetting;
