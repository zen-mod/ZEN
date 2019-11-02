[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    ELSTRING(common,Category),
    false,
    false,
    {
        params ["_value"];

        if (isNull findDisplay IDD_RSCDISPLAYCURATOR) exitWith {};

        if (!_value) then {
            [""] call FUNC(setupPreview);
        };
    }
] call CBA_settings_fnc_init;
