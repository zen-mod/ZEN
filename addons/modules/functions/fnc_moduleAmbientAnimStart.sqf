#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to start an ambient animation.
 *
 * Arguments:
 * 0: Unit <OBJECT>
 * 1: Animation Type <NUMBER>
 * 2: Combat Ready <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [unit, 0, true] call zen_modules_fnc_moduleAmbientAnimStart
 *
 * Public: No
 */

#define COMBAT_REACTION_DELAY 0.75

params ["_unit", "_animationType", "_combatReady"];

// Stop animation selected, exit with animation cancel
if (_animationType == 0) exitWith {
    [_unit] call FUNC(moduleAmbientAnimEnd);
};

// Unit is in ambient animation, cancel current and start new one next frame
if (!isNil {_unit getVariable QGVAR(ambientAnimList)}) exitWith {
    [_unit] call FUNC(moduleAmbientAnimEnd);
    [FUNC(moduleAmbientAnimStart), _this] call CBA_fnc_execNextFrame;
};

// Get list of animations for selected type
// Based off of BI's ambient animation function
private _animations = switch (_animationType) do {
    case 1: { // SIT_LOW_1, SIT_LOW_2, SIT_LOW_3, SIT_LOW_4, SIT_LOW_5, SIT_LOW_6
        selectRandom [
            ["amovpsitmstpslowwrfldnon", "amovpsitmstpslowwrfldnon_weaponcheck1", "amovpsitmstpslowwrfldnon_weaponcheck2"],
            ["passenger_flatground_crosslegs"],
            ["Acts_passenger_flatground_leanright"],
            ["commander_sdv"],
            ["passenger_flatground_2_Idle_Unarmed"],
            ["passenger_flatground_3_Idle_Unarmed"]
        ]
    };
    case 2: { // SIT_ARMED_1, SIT_ARMED_2, SIT_ARMED_3, SIT_ARMED_4
        selectRandom [
            ["passenger_flatground_1_Idle_Pistol_Idling"],
            ["passenger_flatground_1_Idle_Pistol"],
            ["passenger_flatground_1_Idle_Idling"],
            ["passenger_flatground_3_Idle_Idling"]
        ]
    };
    case 3: { // SQUAT
        ["Acts_AidlPercMstpSnonWnonDnon_warmup_4_loop"]
    };
    case 4: { // SQUAT_ARMED
        ["Acts_AidlPercMstpSloWWrflDnon_warmup_6_loop"]
    };
    case 5: { // LEAN
        selectRandom [
            ["inbasemoves_lean1"],
            ["Acts_leaning_against_wall"]
        ]
    };
    case 6: { // WATCH_1, WATCH_2
        selectRandom [
            ["inbasemoves_patrolling1"], ["inbasemoves_patrolling2"]
        ]
    };
    case 7: { // STAND_1, STAND_2
        selectRandom [
            ["HubStanding_idle1", "HubStanding_idle2", "HubStanding_idle3"],
            ["amovpercmstpslowwrfldnon", "amovpercmstpslowwrfldnon", "aidlpercmstpslowwrfldnon_g01", "aidlpercmstpslowwrfldnon_g02", "aidlpercmstpslowwrfldnon_g03", "aidlpercmstpslowwrfldnon_g05"]
        ]
    };
    case 8: { // STAND_NO_WEAP_1, STAND_NO_WEAP_2, STAND_NO_WEAP_3, STAND_NO_WEAP_4, STAND_NO_WEAP_5
        selectRandom [
            ["HubStandingUA_idle1", "HubStandingUA_idle2", "HubStandingUA_idle3", "HubStandingUA_move1", "HubStandingUA_move2"],
            ["HubStandingUB_idle1", "HubStandingUB_idle2", "HubStandingUB_idle3", "HubStandingUB_move1"],
            ["HubStandingUC_idle1", "HubStandingUC_idle2", "HubStandingUC_idle3", "HubStandingUC_move1", "HubStandingUC_move2"],
            ["HubBriefing_think"],
            ["Acts_AidlPercMstpSnonWnonDnon_warmup_1_loop","Acts_AidlPercMstpSnonWnonDnon_warmup_2_loop", "Acts_AidlPercMstpSnonWnonDnon_warmup_8_loop"]
        ]
    };
    case 9: { // STAND_PISTOL_1, STAND_PISTOL_2, STAND_PISTOL_3, STAND_PISTOL_4
        selectRandom [
            ["Acts_AidlPercMstpSloWWpstDnon_warmup_1_loop"],
            ["Acts_AidlPercMstpSloWWpstDnon_warmup_2_loop"],
            ["Acts_AidlPercMstpSloWWpstDnon_warmup_3_loop"],
            ["Acts_AidlPercMstpSloWWpstDnon_warmup_6_loop"]
        ]
    };
    case 10: { // GUARD
        ["inbasemoves_handsbehindback1", "inbasemoves_handsbehindback2"]
    };
    case 11: { // GUARD_KNEEL
        ["viper_crouchLoop", "viperSgt_crouchLoop"]
    };
    case 12: { // LISTEN_BRIEFING
        ["unaercposlechvelitele1", "unaercposlechvelitele2", "unaercposlechvelitele3", "unaercposlechvelitele4"]
    };
    case 13: { // BRIEFING
        ["hubbriefing_loop", "hubbriefing_loop", "hubbriefing_loop", "hubbriefing_lookaround1", "hubbriefing_lookaround2", "hubbriefing_scratch", "hubbriefing_stretch", "hubbriefing_talkaround"]
    };
    case 14: { // BRIEFING_INTERACTIVE_1, BRIEFING_INTERACTIVE_2
        selectRandom [
            ["Acts_C_in1_briefing"], ["Acts_HUBABriefing"]
        ]
    };
    case 15: { // LISTEN_CIV
        ["Acts_CivilListening_1", "Acts_CivilListening_2"]
    };
    case 16: { // TALK_CIV
        ["Acts_CivilTalking_1", "Acts_CivilTalking_2"]
    };
    case 17: { // LISTEN_TO_RADIO
        ["Acts_listeningToRadio_Loop"]
    };
    case 18: { // SHIELD_FROM_SUN
        ["Acts_ShieldFromSun_Loop"]
    };
    case 19: { // NAVIGATE
        ["Acts_NavigatingChopper_Loop"]
    };
    case 20: { // SHOWING_THE_WAY
        ["Acts_ShowingTheRightWay_loop"]
    };
    case 21: { // KNEEL_TREAT_1, KNEEL_TREAT_2
        selectRandom [
            ["ainvpknlmstpsnonwnondnon_medic", "ainvpknlmstpsnonwnondnon_medic0", "ainvpknlmstpsnonwnondnon_medic1", "ainvpknlmstpsnonwnondnon_medic2", "ainvpknlmstpsnonwnondnon_medic3", "ainvpknlmstpsnonwnondnon_medic4", "ainvpknlmstpsnonwnondnon_medic5"],
            ["acts_treatingwounded01", "acts_treatingwounded02", "acts_treatingwounded03", "acts_treatingwounded04", "acts_treatingwounded05", "acts_treatingwounded06"]
        ]
    };
    case 22: { // PRONE_INJURED
        ["acts_injuredangryrifle01", "acts_injuredcoughrifle02", "acts_injuredlookingrifle01", "acts_injuredlookingrifle02", "acts_injuredlookingrifle03", "acts_injuredlookingrifle04", "acts_injuredlookingrifle05", "acts_injuredlyingrifle01"]
    };
    case 23: { // PRONE_INJURED_NO_WEAP_1, PRONE_INJURED_NO_WEAP_2
        selectRandom [
            ["ainjppnemstpsnonwnondnon"],
            ["hubwoundedprone_idle1", "hubwoundedprone_idle2"]
        ]
    };
    case 24: { // LEAN_INJURED
        ["Acts_SittingWounded_loop"]
    };
    case 25: { // INJURY_HEAD
        ["Acts_CivilInjuredHead_1"]
    };
    case 26: { // INJURY_CHEST
        ["Acts_CivilinjuredChest_1"]
    };
    case 27: { // INJURY_ARM
        ["Acts_CivilInjuredArms_1"]
    };
    case 28: { // INJURY_LEG
        ["Acts_CivilInjuredLegs_1"]
    };
    case 29: { // CIV_SHOCK
        ["Acts_CivilShocked_1", "Acts_CivilShocked_2"]
    };
    case 30: { // CIV_HIDE
        ["Acts_CivilHiding_1", "Acts_CivilHiding_2"]
    };
    case 31: { // SURRENDER
        ["Acts_JetsMarshallingStop_loop"]
    };
    case 32: { // CAPTURED_SIT
        ["Acts_AidlPsitMstpSsurWnonDnon03", "Acts_AidlPsitMstpSsurWnonDnon04", "Acts_AidlPsitMstpSsurWnonDnon05"]
    };
    case 33: { // REPAIR_VEH_STAND
        ["inbasemoves_assemblingvehicleerc"]
    };
    case 34: { // REPAIR_VEH_KNEEL
        ["inbasemoves_repairvehicleknl"]
    };
    case 35: { // REPAIR_VEH_PRONE
        ["hubfixingvehicleprone_idle1"]
    };
    case 36: { // DEAD_1, // DEAD_2, // DEAD_3, // DEAD_4, // DEAD_5, // DEAD_6, // DEAD_7, // DEAD_8, // DEAD_9
        selectRandom [
            ["Acts_StaticDeath_01"],
            ["Acts_StaticDeath_02"],
            ["Acts_StaticDeath_03"],
            ["Acts_StaticDeath_04"],
            ["Acts_StaticDeath_05"],
            ["Acts_StaticDeath_06"],
            ["Acts_StaticDeath_07"],
            ["Acts_StaticDeath_08"],
            ["Acts_StaticDeath_09"]
        ]
    };
    case 37: { // DEAD_LEAN_1, DEAD_LEAN_2
        selectRandom [
            ["KIA_Commander_MBT_04"],
            ["KIA_driver_MBT_04"]
        ]
    };
    case 38: { // DEAD_SIT_1, DEAD_SIT_2, DEAD_SIT_3
        selectRandom [
            ["KIA_passenger_flatground"],
            ["KIA_passenger_sdv"],
            ["KIA_commander_sdv"]
        ]
    };
    case 39: { // TABLE
        ["InBaseMoves_table1"]
    };
    case 40: { // BINOCS
        ["passenger_flatground_1_Aim_binoc"]
    };
    case 41: { // SALUTE
        ["AmovPercMstpSrasWrflDnon_Salute"]
    };
};

// Store animation list and current animation for resetting
_unit setVariable [QGVAR(ambientAnimList), _animations];
_unit setVariable [QGVAR(ambientAnimStart), animationState _unit];

// Disable AI intelligence to prevent animation interrupt
[QEGVAR(common,disableAI), [_unit, ["ANIM", "AUTOTARGET", "FSM", "MOVE", "TARGET"]], _unit] call CBA_fnc_targetEvent;

// Play a random animation to start the ambient animation loop
[QEGVAR(common,switchMove), [_unit, selectRandom _animations]] call CBA_fnc_globalEvent;

// Add event handler to play animation again when animation finishes
private _animDoneEH = _unit addEventHandler ["AnimDone", {
    params ["_unit"];

    private _animations = _unit getVariable [QGVAR(ambientAnimList), []];
    [QEGVAR(common,switchMove), [_unit, selectRandom _animations]] call CBA_fnc_globalEvent;
}];

_unit setVariable [QGVAR(ambientAnimDoneEH), _animDoneEH];

// Add event handler to cancel animation when unit is killed
// MP event handler since killed EH is only executed where the unit is local
// Ensures execution without having to add event handler everywhere to handle locality change
private _killedEH = _unit addMPEventHandler ["MPKilled", {
    if (isServer) then {
        _this call FUNC(moduleAmbientAnimEnd);
    };
}];

_unit setVariable [QGVAR(ambientAnimKilledEH), _killedEH];

// Add event handler to cancel animation if fired near and combat ready enabled
if (_combatReady) then {
    private _firedNearEH = _unit addEventHandler ["FiredNear", {
        [{
            params ["_unit"];

            if (alive _unit) then {
                [_unit] call FUNC(moduleAmbientAnimEnd);
            };
        }, _this, COMBAT_REACTION_DELAY] call CBA_fnc_waitAndExecute;
    }];

    _unit setVariable [QGVAR(ambientAnimFiredNearEH), _firedNearEH];
};
