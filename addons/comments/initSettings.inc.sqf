[
    QGVAR(enable3DENComments),
    "CHECKBOX",
    [LLSTRING(3DENComments), LLSTRING(3DENComments_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    0
] call CBA_fnc_addSetting;

[
    QGVAR(3DENCommentsColor),
    "COLOR",
    [LLSTRING(3DENCommentsColor), LLSTRING(3DENCommentsColor_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [0, 1, 0.75, 1],
    0
] call CBA_fnc_addSetting;
