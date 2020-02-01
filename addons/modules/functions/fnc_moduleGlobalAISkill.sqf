#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to globally set AI skills.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleGlobalAISkill
 *
 * Public: No
 */

params ["_logic"];

deleteVehicle _logic;

EGVAR(ai,skills) params [
    "_enabled",
    "_general",
    "_accuracy",
    "_aimingSpeed",
    "_aimingShake",
    "_commanding",
    "_courage",
    "_spotDistance",
    "_spotTime",
    "_reloadSpeed",
    "_cover",
    "_combat",
    "_suppression"
];

[LSTRING(GlobalAISkill), [
    [
        "TOOLBOX:ENABLED",
        [LSTRING(GlobalAISkill_Enabled), LSTRING(GlobalAISkill_Enabled_Description)],
        _enabled,
        true
    ],
    [
        "SLIDER:PERCENT",
        "STR_General",
        [0, 1, _general],
        true
    ],
    [
        "SLIDER:PERCENT",
        ELSTRING(ai,AimingAccuracy),
        [0, 1, _accuracy],
        true
    ],
    [
        "SLIDER:PERCENT",
        ELSTRING(ai,AimingSpeed),
        [0, 1, _aimingSpeed],
        true
    ],
    [
        "SLIDER:PERCENT",
        ELSTRING(ai,AimingShake),
        [0, 1, _aimingShake],
        true
    ],
    [
        "SLIDER:PERCENT",
        ELSTRING(ai,Commanding),
        [0, 1, _commanding],
        true
    ],
    [
        "SLIDER:PERCENT",
        ELSTRING(ai,Courage),
        [0, 1, _courage],
        true
    ],
    [
        "SLIDER:PERCENT",
        ELSTRING(ai,SpotDistance),
        [0, 1, _spotDistance],
        true
    ],
    [
        "SLIDER:PERCENT",
        ELSTRING(ai,SpotTime),
        [0, 1, _spotTime],
        true
    ],
    [
        "SLIDER:PERCENT",
        ELSTRING(ai,ReloadSpeed),
        [0, 1, _reloadSpeed],
        true
    ],
    [
        "TOOLBOX:YESNO",
        ELSTRING(ai,SeekCover),
        _cover,
        true
    ],
    [
        "TOOLBOX:YESNO",
        ELSTRING(ai,AutoCombat),
        _combat,
        true
    ],
    [
        "TOOLBOX:YESNO",
        ELSTRING(ai,Suppression),
        _suppression,
        true
    ]
], {
    params ["_values"];

    EGVAR(ai,skills) = _values;
    publicVariable QEGVAR(ai,skills);

    // Public variable event handler won't trigger for local machine, manually call
    ["", EGVAR(ai,skills)] call EFUNC(ai,handleSkillsChange);
}] call EFUNC(dialog,create);
