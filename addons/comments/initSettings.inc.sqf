[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    [ELSTRING(main,DisplayName), "STR_3DEN_Comment_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enabled3DEN),
    "CHECKBOX",
    [LSTRING(Enabled3DEN), LSTRING(Enabled3DEN_Description)],
    [ELSTRING(main,DisplayName), "STR_3DEN_Comment_textPlural"],
    true,
    false
] call CBA_fnc_addSetting;

[
    QGVAR(colorDefault),
    "COLOR",
    [LSTRING(ColorDefault), LSTRING(ColorDefault_Description)],
    [ELSTRING(main,DisplayName), "STR_3DEN_Comment_textPlural"],
    [1, 1, 0],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(color3DEN),
    "COLOR",
    [LSTRING(Color3DEN), LSTRING(Color3DEN_Description)],
    [ELSTRING(main,DisplayName), "STR_3DEN_Comment_textPlural"],
    [0, 1, 0.75],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(allowDeleting3DEN),
    "CHECKBOX",
    [LSTRING(AllowDeleting3DEN), LSTRING(AllowDeleting3DEN_Description)],
    [ELSTRING(main,DisplayName), "STR_3DEN_Comment_textPlural"],
    false,
    false
] call CBA_fnc_addSetting;
