#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles changing a CBA setting.
 *
 * Arguments:
 * 0: Setting <STRING>
 * 1: Value <ANY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_setting, _value] call zen_comments_fnc_handleSettingChanged
 *
 * Public: No
 */

params ["_setting", "_value"];

if (_setting == QGVAR(color3DEN)) exitWith {
    {
        [_y] call FUNC(updateIconColor);
    } forEach GVAR(icons);
};

if (_setting in [QGVAR(enabled), QGVAR(enabled3DEN)]) exitWith {
    private _is3DENSetting = _setting == QGVAR(enabled3DEN);

    {
        private _is3DENComment = [_x] call FUNC(is3DENComment);

        if (_is3DENSetting isEqualTo _is3DENComment) then {
            if (_value) then {
                [_x] call FUNC(createIcon);
            } else {
                [_x] call FUNC(deleteIcon);
            };
        };
    } forEach GVAR(comments);
};
