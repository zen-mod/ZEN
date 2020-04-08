#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to make a unit play an ambient animation.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleAmbientAnim
 *
 * Public: No
 */

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

if !(_unit isKindOf "CAManBase") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if !(alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

if (isPlayer _unit) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call EFUNC(common,showMessage);
};

[LSTRING(ModuleAmbientAnim), [
    ["COMBO", LSTRING(ModuleAmbientAnim_Type), [[], [
        [LSTRING(ModuleAmbientAnim_StopAnimation), "", "", [0.8, 0, 0, 1]],
        LSTRING(ModuleAmbientAnim_SitOnFloor),
        LSTRING(ModuleAmbientAnim_SitArmed),
        LSTRING(ModuleAmbientAnim_Squat),
        LSTRING(ModuleAmbientAnim_SquatArmed),
        LSTRING(ModuleAmbientAnim_LeanOnWall),
        LSTRING(ModuleAmbientAnim_Watch),
        LSTRING(ModuleAmbientAnim_StandIdle),
        LSTRING(ModuleAmbientAnim_StandIdleNoWeapon),
        LSTRING(ModuleAmbientAnim_StandWithPistol),
        LSTRING(ModuleAmbientAnim_AtEase),
        LSTRING(ModuleAmbientAnim_GuardKneeled),
        LSTRING(ModuleAmbientAnim_ListenToBriefing),
        LSTRING(ModuleAmbientAnim_Briefing),
        LSTRING(ModuleAmbientAnim_BriefingInteractive),
        LSTRING(ModuleAmbientAnim_ListeningCivilian),
        LSTRING(ModuleAmbientAnim_TalkingCivilian),
        LSTRING(ModuleAmbientAnim_ListenToRadio),
        LSTRING(ModuleAmbientAnim_ShieldFromSun),
        LSTRING(ModuleAmbientAnim_NavigateAircraft),
        LSTRING(ModuleAmbientAnim_ShowVehicleTheWay),
        LSTRING(ModuleAmbientAnim_TreatWounded),
        LSTRING(ModuleAmbientAnim_CombatWounded),
        LSTRING(ModuleAmbientAnim_WoundedGeneral),
        LSTRING(ModuleAmbientAnim_WoundedLeaning),
        LSTRING(ModuleAmbientAnim_WoundedHead),
        LSTRING(ModuleAmbientAnim_WoundedChest),
        LSTRING(ModuleAmbientAnim_WoundedArm),
        LSTRING(ModuleAmbientAnim_WoundedLeg),
        LSTRING(ModuleAmbientAnim_ShockedCivilian),
        LSTRING(ModuleAmbientAnim_HidingCivilian),
        LSTRING(ModuleAmbientAnim_Surrender),
        LSTRING(ModuleAmbientAnim_SitCaptured),
        LSTRING(ModuleAmbientAnim_RepairStand),
        LSTRING(ModuleAmbientAnim_RepairKneel),
        LSTRING(ModuleAmbientAnim_RepairProne),
        LSTRING(ModuleAmbientAnim_Dead),
        LSTRING(ModuleAmbientAnim_DeadLeaning),
        LSTRING(ModuleAmbientAnim_DeadSit),
        LSTRING(ModuleAmbientAnim_LeanOnTable),
        LSTRING(ModuleAmbientAnim_Binoculars),
        LSTRING(ModuleAmbientAnim_Salute)
    ], 0]],
    ["TOOLBOX:YESNO", LSTRING(ModuleAmbientAnim_Combat), true]
], {
    params ["_dialogValues", "_unit"];
    _dialogValues params ["_animationType", "_combatReady"];

    [QGVAR(moduleAmbientAnimStart), [_unit, _animationType, _combatReady]] call CBA_fnc_serverEvent;
}, {}, _unit] call EFUNC(dialog,create);
