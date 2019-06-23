#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Current NVG brightness
GVAR(brightness) = 0;

// Init post process NVG brightness effect
GVAR(ppBrightness) = ppEffectCreate ["ColorCorrections", 482482];
GVAR(ppBrightness) ppEffectForceInNVG true;
GVAR(ppBrightness) ppEffectAdjust [1, 1, 0, [0, 0, 0, 0], [0, 0, 0, 1], [0, 0, 0, 1]];
GVAR(ppBrightness) ppEffectCommit 0;
GVAR(ppBrightness) ppEffectEnable false;

["CBA_SettingChanged", {
    params ["_name"];

    if (_name in [QGVAR(enableNVG), QGVAR(enableWhiteHot), QGVAR(enableBlackHot), QGVAR(enableGreenHotCold), QGVAR(enableBlackHotGreenCold), QGVAR(enableRedHotCold), QGVAR(enableBlackHotRedCold), QGVAR(enableWhiteHotRedCold), QGVAR(enableRedGreenThermal)]) then {
        [] call FUNC(setModes);
    };
}] call CBA_fnc_addEventHandler;

["ZEN_displayCuratorLoad", {
    [] call FUNC(setModes);
    FUNC(updateEffect) call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

["ZEN_displayCuratorUnload", {
    GVAR(ppBrightness) ppEffectEnable false;
}] call CBA_fnc_addEventHandler;
