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
    QGVAR(toggleSpeed),
    [LSTRING(ToggleSpeed), LSTRING(ToggleSpeed_Description)],
    {
        if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
            private _numSpeeds = count (GVAR(speedFormatters) select GVAR(currentSpeedFormatter) select 3);
            GVAR(currentSpeedIndex) = (GVAR(currentSpeedIndex) + 1) % _numSpeeds;

            true
        };
    },
    {},
    [DIK_R, [true, false, false]] // Default: SHIFT + R
] call CBA_fnc_addKeybind;

[
    _category,
    QGVAR(toggleSpeedFormat),
    [LSTRING(ToggleSpeedFormat), LSTRING(ToggleSpeedFormat_Description)],
    {
        if (!isNull curatorCamera && {!GETMVAR(RscDisplayCurator_search,false)}) then {
            private _numFormatters = count GVAR(speedFormatters);
            GVAR(currentSpeedFormatter) = (GVAR(currentSpeedFormatter) + 1) % _numFormatters;

            GVAR(currentSpeedIndex) = 0;

            true
        };
    },
    {},
    [DIK_R, [false, false, true]] // Default: ALT + R
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
            if (GVAR(history) isNotEqualTo []) then {
                private _lastPlotId = (GVAR(history) deleteAt [-1]) select 0;
                private _lastPlot = GVAR(plots) deleteAt _lastPlotId;
                [QGVAR(plotDeleted), [_lastPlotId] + _lastPlot] call CBA_fnc_localEvent;
                TRACE_2("Removed last plot",_lastPlotId,_lastPlot);

                // Automatically delete invalid plots (e.g. when attached object does not exist anymore)
                while {GVAR(history) isNotEqualTo []} do {
                    _lastPlotId = GVAR(history) select -1;

                    if !([_lastPlotId] call FUNC(isValidPlot)) then {
                        GVAR(history) deleteAt [-1];
                        _lastPlot = GVAR(plots) deleteAt _lastPlotId;
                        [QGVAR(plotDeleted), [_lastPlotId] + _lastPlot] call CBA_fnc_localEvent;
                        TRACE_2("Automatically removed next invalid plot",_lastPlotId,_lastPlot);
                    };
                };
            };

            true
        };
    },
    {},
    [DIK_Y, [false, true, false]] // Default: Ctrl + Y
] call CBA_fnc_addKeybind;
