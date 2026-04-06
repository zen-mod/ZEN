private _category = [ELSTRING(main,DisplayName), LSTRING(DisplayName)];

[
    QGVAR(color),
    "COLOR",
    localize "str_3den_marker_attribute_color_displayname",
    _category,
    [0.9, 0.9, 0, 1],
    0
] call CBA_fnc_addSetting;
