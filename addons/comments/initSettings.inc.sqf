[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    true,
    {
        TRACE_1("Enable comments setting changed",_this);

        private _display = findDisplay IDD_RSCDISPLAYCURATOR;
        if (!_this || GVAR(enable3DENComments) || isNull _display || GVAR(draw3DAdded)) exitWith {};
        [_display] call FUNC(addDrawEventHandler);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(color),
    "COLOR",
    [LSTRING(Color), LSTRING(Color_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [1, 1, 0],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(color3DEN),
    "COLOR",
    [LSTRING(Color3DEN), LSTRING(Color3DEN_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [0, 1, 0.75],
    false
] call CBA_fnc_addSetting;

[
    QGVAR(enable3DENComments),
    "CHECKBOX",
    [LLSTRING(3DENComments), LLSTRING(3DENComments_Description)],
    [ELSTRING(main,DisplayName), LLSTRING(DisplayName)],
    true,
    0,
    {
        TRACE_1("Enable 3DEN comments setting changed",_this);

        private _display = findDisplay IDD_RSCDISPLAYCURATOR;
        if (!_this || GVAR(enableComments) || isNull _display || GVAR(draw3DAdded)) exitWith {};
        [_display] call FUNC(addDrawEventHandler);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(allowDeleting3DENComments),
    "CHECKBOX",
    [LLSTRING(AllowDeleting3DENComments), LLSTRING(AllowDeleting3DENComments_Description)],
    [ELSTRING(main,DisplayName), LLSTRING(DisplayName)],
    false,
    0
] call CBA_fnc_addSetting;
