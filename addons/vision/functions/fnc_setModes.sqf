/*
 * Author: mharis001
 * Updates avaiable curator vision modes based on settings.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_vision_fnc_setModes
 *
 * Public: No
 */
#include "script_component.hpp"

private _curator = getAssignedCuratorLogic player;
private _modes = [-1]; // Default is always available

if (GVAR(enableNVG)) then {
    _modes pushBack -2;
};

{
    if (_x) then {_modes pushBack _forEachIndex};
} forEach [
    GVAR(enableWhiteHot),
    GVAR(enableBlackHot),
    GVAR(enableGreenHotCold),
    GVAR(enableBlackHotGreenCold),
    GVAR(enableRedHotCold),
    GVAR(enableBlackHotRedCold),
    GVAR(enableWhiteHotRedCold),
    GVAR(enableRedGreenThermal)
];

[_curator, _modes] call BIS_fnc_setCuratorVisionModes;
