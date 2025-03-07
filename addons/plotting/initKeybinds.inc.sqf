private _category = [ELSTRING(main,DisplayName), LSTRING(DisplayName)];

[
    _category,
    QGVAR(toggleDistanceFormat),
    LSTRING(ToggleDistanceFormat),
    {
        if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
            private _numFormatters = count GVAR(distanceFormatters);
            GVAR(currentDistanceFormatter) = (GVAR(currentDistanceFormatter) + 1) % _numFormatters;

            true
        };
    },
    {},
    [DIK_R, [false, false, false]] // Default: R
] call CBA_fnc_addKeybind;

[
    _category,
    QGVAR(toggleAzimuthFormat),
    LSTRING(ToggleAzimuthFormat),
    {
        if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
            private _numFormatters = count GVAR(azimuthFormatters);
            GVAR(currentAzimuthFormatter) = (GVAR(currentAzimuthFormatter) + 1) % _numFormatters;

            true
        };
    },
    {},
    [DIK_TAB, [false, false, false]] // Default: Tab
] call CBA_fnc_addKeybind;
