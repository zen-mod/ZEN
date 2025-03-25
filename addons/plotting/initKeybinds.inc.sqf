private _category = [ELSTRING(main,DisplayName), LSTRING(DisplayName)];

[
    _category,
    QGVAR(toggleDistanceFormat),
    [LSTRING(ToggleDistanceFormat), LSTRING(ToggleDistanceFormat_Description)],
    {
        if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
            private _numFormatters = count GVAR(distanceFormatters);
            GVAR(currentDistanceFormatter) = (GVAR(currentDistanceFormatter) + 1) % _numFormatters;

            true
        };
    },
    {},
    [DIK_R, [false, true, false]] // Default: CTRL + R
] call CBA_fnc_addKeybind;

[
    _category,
    QGVAR(toggleSpeedFormat),
    [LSTRING(ToggleSpeedFormat), LSTRING(ToggleSpeedFormat_Description)],
    {
        if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
            private _numFormatters = count GVAR(speedFormatters);
            GVAR(currentSpeedFormatter) = (GVAR(currentSpeedFormatter) + 1) % _numFormatters;

            true
        };
    },
    {},
    [DIK_R, [true, false, false]] // Default: SHIFT + R
] call CBA_fnc_addKeybind;

[
    _category,
    QGVAR(toggleAzimuthFormat),
    [LSTRING(ToggleAzimuthFormat), LSTRING(ToggleAzimuthFormat_Description)],
    {
        if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
            private _numFormatters = count GVAR(azimuthFormatters);
            GVAR(currentAzimuthFormatter) = (GVAR(currentAzimuthFormatter) + 1) % _numFormatters;

            true
        };
    },
    {},
    [DIK_T, [false, true, false]] // Default: CTRL + T
] call CBA_fnc_addKeybind;

[
    _category,
    QGVAR(deleteLastPlot),
    [LSTRING(DeleteLastPlot), LSTRING(DeleteLastPlot_Description)],
    {
        if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
            if (GVAR(plots) isNotEqualTo []) then {
                private _lastPlot = GVAR(plots) deleteAt [-1];
                TRACE_1("Removed last plot",_lastPlot);

                // Automatically delete invalid plots (e.g. when attached object does not exist anymore)
                while {GVAR(plots) isNotEqualTo []} do {
                    (GVAR(plots) select -1) params ["", "_startPos", "_endPos"];

                    if ((_startPos isEqualTo objNull) || {_endPos isEqualTo objNull}) then {
                        _lastPlot = GVAR(plots) deleteAt [-1];
                        TRACE_1("Automatically removed next invalid plot",_lastPlot);
                    };
                };
            };

            true
        };
    },
    {},
    [DIK_Y, [false, true, false]] // Default: Ctrl + Y
] call CBA_fnc_addKeybind;
