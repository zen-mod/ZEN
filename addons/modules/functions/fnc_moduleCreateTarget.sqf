#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create a target logic.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleCreateTarget
 *
 * Public: No
 */

params ["_logic"];

[LSTRING(ModuleCreateTarget), [
    [
        "EDIT",
        LSTRING(ModuleCreateTarget_Name),
        [_logic, LSTRING(ModuleCreateTarget_Format)] call EFUNC(position_logics,nextName),
        true
    ],
    [
        "COMBO",
        LSTRING(ModuleCreateTarget_AttachLaser),
        [nil, [
            ["STR_A3_None", "", QPATHTOF(ui\none_ca.paa)],
            ["STR_WEST", "", ICON_BLUFOR],
            ["STR_EAST", "", ICON_OPFOR],
            ["STR_Guerrila", "", ICON_INDEPENDENT]
        ]]
    ]
], {
    params ["_values", "_logic"];
    _values params ["_name", "_attachedLaser"];

    if (_attachedLaser != 0) then {
        if (_attachedLaser == 3) then {
            _attachedLaser = parseNumber ([west, independent] call BIS_fnc_sideIsEnemy);
        } else {
            _attachedLaser = _attachedLaser - 1;
        };

        private _laserType = ["LaserTargetW", "LaserTargetE"] select _attachedLaser;
        private _laser = createVehicle [_laserType, [0, 0, 0], [], 0, "NONE"];
        _laser setVariable [QEGVAR(position_logics,delete), true, true];
        _laser attachTo [_logic, [0, 0, 0]];
    };

    [_logic, _name] call EFUNC(position_logics,add);
}, {
    params ["", "_logic"];

    deleteVehicle _logic;
}, _logic] call EFUNC(dialog,create);
