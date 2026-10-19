private _category = [ELSTRING(main,DisplayName), localize STR_DISPLAY_NAME];

[
    QGVAR(enabled),
    "CHECKBOX",
    [LLSTRING(Comments), LLSTRING(Comments_Description)],
    _category,
    true,
    0,
    {
        TRACE_1("Enable comments setting changed",_this);

        private _display = findDisplay IDD_RSCDISPLAYCURATOR;
        if (!_this || GVAR(enabled3DEN) || isNull _display || GVAR(draw3DAdded)) exitWith {};
        [_display] call FUNC(addDrawEventHandler);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(enabled3DEN),
    "CHECKBOX",
    [LLSTRING(3DENComments), LLSTRING(3DENComments_Description)],
    _category,
    true,
    0,
    {
        TRACE_1("Enable 3DEN comments setting changed",_this);

        private _display = findDisplay IDD_RSCDISPLAYCURATOR;
        if (!_this || GVAR(enabled) || isNull _display || GVAR(draw3DAdded)) exitWith {};
        [_display] call FUNC(addDrawEventHandler);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(3DENColor),
    "COLOR",
    [LLSTRING(3DENCommentColor), LLSTRING(3DENCommentColor_Description)],
    _category,
    [0, 1, 0.75, 0.7],
    0
] call CBA_fnc_addSetting;

[
    QGVAR(allowDeleting3DEN),
    "CHECKBOX",
    [LLSTRING(AllowDeleting3DENComments), LLSTRING(AllowDeleting3DENComments_Description)],
    _category,
    false,
    0
] call CBA_fnc_addSetting;
