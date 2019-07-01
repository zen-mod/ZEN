#include "script_component.hpp"

if (!hasInterface) exitWith {};

["CBA_SettingChanged", {
    params ["_name"];

    if (_name in [QGVAR(followTerrain), QGVAR(adaptiveSpeed), QGVAR(defaultSpeedCoef), QGVAR(fastSpeedCoef)]) then {
        [] call FUNC(updateSettings);
    };
}] call CBA_fnc_addEventHandler;

["ZEN_displayCuratorLoad", {
    FUNC(updateSettings) call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;
