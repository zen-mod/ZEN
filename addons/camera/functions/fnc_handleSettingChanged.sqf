#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles changing a CBA setting.
 *
 * Arguments:
 * 0: Setting <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_setting] call zen_camera_fnc_handleSettingChanged
 *
 * Public: No
 */

params ["_setting"];

if (
    _setting in [
        QGVAR(followTerrain),
        QGVAR(adaptiveSpeed),
        QGVAR(defaultSpeedCoef),
        QGVAR(fastSpeedCoef)
    ]
) then {
    [] call FUNC(updateSettings);
};
