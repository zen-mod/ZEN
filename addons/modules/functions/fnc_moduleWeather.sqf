#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to change the weather.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleWeather
 *
 * Public: No
 */

params ["_logic"];

[LSTRING(ModuleWeather), [
    [
        "TOOLBOX:YESNO",
        [LSTRING(ModuleWeather_Forced), LSTRING(ModuleWeather_Forced_Tooltip)],
        true
    ],
    [
        "SLIDER:PERCENT",
        [LSTRING(ModuleWeather_Overcast), LSTRING(ModuleWeather_Overcast_Tooltip)],
        [0, 1, overcast],
        true
    ],
    [
        "SLIDER:PERCENT",
        [LSTRING(ModuleWeather_Rain), LSTRING(ModuleWeather_Rain_Tooltip)],
        [0, 1, rain],
        true
    ],
    [
        "SLIDER:PERCENT",
        [LSTRING(ModuleWeather_Lightning), LSTRING(ModuleWeather_Lightning_Tooltip)],
        [0, 1, lightnings],
        true
    ],
    [
        "SLIDER:PERCENT",
        [LSTRING(ModuleWeather_Rainbow), LSTRING(ModuleWeather_Rainbow_Tooltip)],
        [0, 1, rainbow],
        true
    ],
    [
        "SLIDER:PERCENT",
        [LSTRING(ModuleWeather_Waves), LSTRING(ModuleWeather_Waves_Tooltip)],
        [0, 1, waves],
        true
    ],
    [
        "SLIDER",
        [LSTRING(ModuleWeather_WindSpeed), LSTRING(ModuleWeather_WindSpeed_Tooltip)],
        [0, 120, MS_TO_KMH(vectorMagnitude wind), 1],
        true
    ],
    [
        "SLIDER",
        [LSTRING(ModuleWeather_WindDirection), LSTRING(ModuleWeather_WindDirection_Tooltip)],
        [0, 360, windDir, EFUNC(common,formatDegrees)],
        true
    ],
    [
        "SLIDER:PERCENT",
        [LSTRING(ModuleWeather_Gusts), LSTRING(ModuleWeather_Gusts_Tooltip)],
        [0, 1, gusts],
        true
    ],
    [
        "SLIDER:PERCENT",
        [LSTRING(ModuleWeather_FogDensity), LSTRING(ModuleWeather_FogDensity_Tooltip)],
        [0, 1, fogParams select 0],
        true
    ],
    [
        "SLIDER:PERCENT",
        [LSTRING(ModuleWeather_FogDecay), LSTRING(ModuleWeather_FogDecay_Tooltip)],
        [-1, 1, fogParams select 1],
        true
    ],
    [
        "SLIDER",
        [LSTRING(ModuleWeather_FogAltitude), LSTRING(ModuleWeather_FogAltitude_Tooltip)],
        [-5000, 5000, fogParams select 2, 0],
        true
    ]
], {
    params ["_values"];

    _values params [
        "_forced",
        "_overcast",
        "_rain",
        "_lightning",
        "_rainbow",
        "_waves",
        "_windSpeed",
        "_windDirection",
        "_gusts",
        "_fogDensity",
        "_fogDecay",
        "_fogAltitude"
    ];

    private _wind = [KMH_TO_MS(_windSpeed) * sin _windDirection, KMH_TO_MS(_windSpeed) * cos _windDirection, true];
    private _fog = [_fogDensity, _fogDecay, _fogAltitude];

    [QGVAR(applyWeather), [_forced, _overcast, _rain, _lightning, _rainbow, _waves, _wind, _gusts, _fog]] call CBA_fnc_globalEvent;
}, {}, [], QGVAR(moduleWeather)] call EFUNC(dialog,create);

deleteVehicle _logic;
