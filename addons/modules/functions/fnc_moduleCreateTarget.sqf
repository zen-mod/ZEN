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

private _defaultName = [count GVAR(targetLogics)] call EFUNC(common,getPhoneticName);
_defaultName = format [localize LSTRING(ModuleCreateTarget_TargetX), _defaultName];

[LSTRING(ModuleCreateTarget), [
    ["EDIT", LSTRING(ModuleCreateTarget_Name), _defaultName, true],
    ["COMBO", LSTRING(ModuleCreateTarget_AttachLaser), [[], [
        ["STR_A3_None", "", QPATHTOF(ui\none_ca.paa)],
        ["STR_WEST", "", ICON_BLUFOR],
        ["STR_EAST", "", ICON_OPFOR],
        ["STR_Guerrila", "", ICON_INDEPENDENT]
    ], 0]]
], {
    params ["_dialogValues", "_logic"];
    _dialogValues params ["_targetName", "_attachedLaser"];

    // Add the logic as a target logic
    _logic setName _targetName;

    GVAR(targetLogics) pushBack _logic;
    publicVariable QGVAR(targetLogics);

    // Handle creating an attached laser target
    _attachedLaser = _attachedLaser - 1;

    if (_attachedLaser > -1) then {
        if (_attachedLaser > 2) then {
            _attachedLaser = parseNumber ([west, independent] call BIS_fnc_sideIsEnemy);
        };

        private _laserTargetType = ["LaserTargetW", "LaserTargetE"] select _attachedLaser;
        private _laserTarget = createVehicle [_laserTargetType, [0, 0, 0], [], 0, "NONE"];
        _laserTarget attachTo [_logic, [0, 0, 0]];
    };
}, {
    params ["", "_logic"];
    deleteVehicle _logic;
}, _logic] call EFUNC(dialog,create);
