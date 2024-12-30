[
    QGVAR(enableComments),
    "CHECKBOX",
    [LLSTRING(Comments), LLSTRING(Comments_Description)],
    [ELSTRING(main,DisplayName), LLSTRING(DisplayName)],
    true,
    0,
    {
        TRACE_1("Enable comments setting changed",_this);

        private _display = findDisplay IDD_RSCDISPLAYCURATOR;
        if (!_this || GVAR(enable3DENComments) || isNull _display || GVAR(draw3DAdded)) exitWith {};
        [_display] call FUNC(addDrawEventHandler);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(commentColor),
    "COLOR",
    [LLSTRING(CommentColor), LLSTRING(CommentColor_Description)],
    [ELSTRING(main,DisplayName), LLSTRING(DisplayName)],
    [1, 1, 0, 0.7],
    0,
    {
        TRACE_1("Comment color setting changed",_this);
        params ["_r", "_g", "_b", "_a"];

        GVAR(commentsActiveColor) = [_r, _g, _b, 1];
    }
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
    QGVAR(3DENCommentColor),
    "COLOR",
    [LLSTRING(3DENCommentColor), LLSTRING(3DENCommentColor_Description)],
    [ELSTRING(main,DisplayName), LLSTRING(DisplayName)],
    [0, 1, 0.75, 0.7],
    0,
    {
        TRACE_1("3DEN comment color setting changed",_this);
        params ["_r", "_g", "_b", "_a"];

        GVAR(3DENCommentsActiveColor) = [_r, _g, _b, 1];
    }
] call CBA_fnc_addSetting;
