[
    QGVAR(enabled),
    "CHECKBOX",
    ["STR_A3_OPTIONS_ENABLED", LSTRING(enabled_Description)],
    [ELSTRING(common,Category), "str_a3_rscdisplayoptionsvideo_textvisibility"],
    true,
    false,
    {
        params ["_value"];
        if (isNull (findDisplay IDD_RSCDISPLAYCURATOR)) exitWith {};
        if (_value) then {
            call FUNC(start);
        } else {
            call FUNC(stop);
        };
    }
] call CBA_settings_fnc_init;
