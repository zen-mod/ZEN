[
    QGVAR(enabled),
    "CHECKBOX",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    ELSTRING(main,DisplayName),
    false,
    false,
    {
        params ["_value"];

        if (isNull findDisplay IDD_RSCDISPLAYCURATOR) exitWith {};

        if (_value) then {
            call FUNC(start);
        } else {
            call FUNC(stop);
        };
    }
] call CBA_fnc_addSetting;
