[
    QGVAR(enabled),
    "LIST",
    [LSTRING(Enabled), LSTRING(Enabled_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [
        [
            INDICATOR_DISABLED,
            INDICATOR_ENABLED,
            INDICATOR_PLACEMENT_ONLY
        ],
        [
            ELSTRING(common,Disabled),
            ELSTRING(common,Enabled),
            [LSTRING(DuringPlacementOnly), LSTRING(DuringPlacementOnly_Description)]
        ],
        0
    ],
    false,
    {
        params ["_value"];

        if (isNull findDisplay IDD_RSCDISPLAYCURATOR) exitWith {};

        if (_value != INDICATOR_DISABLED) then {
            call FUNC(start);
        } else {
            call FUNC(stop);
        };
    }
] call CBA_fnc_addSetting;

[
    QGVAR(maxDistance),
    "SLIDER",
    [LSTRING(MaxDistance), LSTRING(MaxDistance_Description)],
    [ELSTRING(main,DisplayName), LSTRING(DisplayName)],
    [100, 5000, 5000, -1],
    false
] call CBA_fnc_addSetting;
