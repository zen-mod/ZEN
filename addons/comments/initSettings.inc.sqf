[
    QGVAR(enable3DENComments),
    "CHECKBOX",
    [LLSTRING(3DENComments), LLSTRING(3DENComments_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    true,
    0,
    {
        TRACE_1("Enable 3DEN comments setting changed",_this);

        private _display = findDisplay IDD_RSCDISPLAYCURATOR;
        if (!_this || isNull _display || GVAR(draw3DAdded)) exitWith {};
        [_display] call FUNC(addDrawEventHandler);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(3DENCommentsColor),
    "COLOR",
    [LLSTRING(3DENCommentsColor), LLSTRING(3DENCommentsColor_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [0, 1, 0.75, 0.7],
    0,
    {
        TRACE_1("3DEN comment color setting changed",_this);
        params ["_r", "_g", "_b", "_a"];

        GVAR(3DENCommentsActiveColor) = [_r, _g, _b, 1];
    }
] call CBA_fnc_addSetting;
