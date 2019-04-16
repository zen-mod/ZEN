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
#include "script_component.hpp"

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
    case 1: { // SIT_LOW
        ["amovpsitmstpslowwrfldnon", "amovpsitmstpslowwrfldnon_weaponcheck1", "amovpsitmstpslowwrfldnon_weaponcheck2"]
    };
    case 2: { // LEAN
        ["inbasemoves_lean1"]
    };
    case 3: { // WATCH_1, WATCH_2
        selectRandom [["inbasemoves_patrolling1"], ["inbasemoves_patrolling2"]]
    };
    case 4: { // STAND_1, STAND_2
        selectRandom [
            ["HubStanding_idle1", "HubStanding_idle2", "HubStanding_idle3"],
            ["amovpercmstpslowwrfldnon", "amovpercmstpslowwrfldnon", "aidlpercmstpslowwrfldnon_g01", "aidlpercmstpslowwrfldnon_g02", "aidlpercmstpslowwrfldnon_g03", "aidlpercmstpslowwrfldnon_g05"]
        ]
    };
    case 5: { // STAND_NO_WEAP_1, STAND_NO_WEAP_2, STAND_NO_WEAP_3
        selectRandom [
            ["HubStandingUA_idle1", "HubStandingUA_idle2", "HubStandingUA_idle3", "HubStandingUA_move1", "HubStandingUA_move2"],
            ["HubStandingUB_idle1", "HubStandingUB_idle2", "HubStandingUB_idle3", "HubStandingUB_move1"],
            ["HubStandingUC_idle1", "HubStandingUC_idle2", "HubStandingUC_idle3", "HubStandingUC_move1", "HubStandingUC_move2"]
        ]
    };
    case 6: { // GUARD
        ["inbasemoves_handsbehindback1", "inbasemoves_handsbehindback2"]
    };
    case 7: { // LISTEN_BRIEFING
        ["unaercposlechvelitele1", "unaercposlechvelitele2", "unaercposlechvelitele3", "unaercposlechvelitele4"]
    };
    case 8: { // BRIEFING
        ["hubbriefing_loop", "hubbriefing_loop", "hubbriefing_loop", "hubbriefing_lookaround1", "hubbriefing_lookaround2", "hubbriefing_scratch", "hubbriefing_stretch", "hubbriefing_talkaround"]
    };
    case 9: { // BRIEFING_INTERACTIVE_1, BRIEFING_INTERACTIVE_2
        selectRandom [["Acts_C_in1_briefing"], ["Acts_HUBABriefing"]]
    };
    case 10: { // LISTEN_CIV
        ["Acts_CivilListening_1", "Acts_CivilListening_2"]
    };
    case 11: { // TALK_CIV
        ["Acts_CivilTalking_1", "Acts_CivilTalking_2"]
    };
    case 12: { // LISTEN_TO_RADIO
        ["Acts_listeningToRadio_Loop"]
    };
    case 13: { // SHIELD_FROM_SUN
        ["Acts_ShieldFromSun_Loop"]
    };
    case 14: { // NAVIGATE
        ["Acts_NavigatingChopper_Loop"]
    };
    case 15: { // SHOWING_THE_WAY
        ["Acts_ShowingTheRightWay_loop"]
    };
    case 16: { // KNEEL_TREAT_1, KNEEL_TREAT_2
        selectRandom [
            ["ainvpknlmstpsnonwnondnon_medic", "ainvpknlmstpsnonwnondnon_medic0", "ainvpknlmstpsnonwnondnon_medic1", "ainvpknlmstpsnonwnondnon_medic2", "ainvpknlmstpsnonwnondnon_medic3", "ainvpknlmstpsnonwnondnon_medic4", "ainvpknlmstpsnonwnondnon_medic5"],
            ["acts_treatingwounded01", "acts_treatingwounded02", "acts_treatingwounded03", "acts_treatingwounded04", "acts_treatingwounded05", "acts_treatingwounded06"]
        ]
    };
    case 17: { // PRONE_INJURED
        ["acts_injuredangryrifle01", "acts_injuredcoughrifle02", "acts_injuredlookingrifle01", "acts_injuredlookingrifle02", "acts_injuredlookingrifle03", "acts_injuredlookingrifle04", "acts_injuredlookingrifle05", "acts_injuredlyingrifle01"]
    };
    case 18: { // PRONE_INJURED_NO_WEAP_1, PRONE_INJURED_NO_WEAP_2
        selectRandom [["ainjppnemstpsnonwnondnon"], ["hubwoundedprone_idle1", "hubwoundedprone_idle2"]]
    };
    case 19: { // INJURY_HEAD
        ["Acts_CivilInjuredHead_1"]
    };
    case 20: { // INJURY_CHEST
        ["Acts_CivilinjuredChest_1"]
    };
    case 21: { // INJURY_ARM
        ["Acts_CivilInjuredArms_1"]
    };
    case 22: { // INJURY_LEG
        ["Acts_CivilInjuredLegs_1"]
    };
    case 23: { // CIV_SHOCK
        ["Acts_CivilShocked_1", "Acts_CivilShocked_2"]
    };
    case 24: { // CIV_HIDE
        ["Acts_CivilHiding_1", "Acts_CivilHiding_2"]
    };
    case 25: { // CAPTURED_SIT
        ["Acts_AidlPsitMstpSsurWnonDnon03", "Acts_AidlPsitMstpSsurWnonDnon04", "Acts_AidlPsitMstpSsurWnonDnon05"]
    };
    case 26: { // REPAIR_VEH_STAND
        ["inbasemoves_assemblingvehicleerc"]
    };
    case 27: { // REPAIR_VEH_KNEEL
        ["inbasemoves_repairvehicleknl"]
    };
    case 28: { // REPAIR_VEH_PRONE
        ["hubfixingvehicleprone_idle1"]
    };
};

// Store animation list and current animation for resetting
_unit setVariable [QGVAR(ambientAnimList), _animations];
_unit setVariable [QGVAR(ambientAnimStart), animationState _unit];

// Disable AI intelligence to prevent animation interrupt
{
    [QEGVAR(common,disableAI), [_unit, _x], _unit] call CBA_fnc_targetEvent;
} forEach ["ANIM", "AUTOTARGET", "FSM", "MOVE", "TARGET"];

// Play a random animation to start the ambient animation loop
[QEGVAR(common,switchMove), [_unit, selectRandom _animations], _unit] call CBA_fnc_globalEvent;

// Add event handler to play animation again when animation finishes
private _animDoneEH = _unit addEventHandler ["AnimDone", {
    params ["_unit"];

    private _animations = _unit getVariable [QGVAR(ambientAnimList), []];
    [QEGVAR(common,switchMove), [_unit, selectRandom _animations], _unit] call CBA_fnc_globalEvent;
}];

_unit setVariable [QGVAR(ambientAnimDoneEH), _animDoneEH];

// Add event handler to cancel animation when unit is killed
private _killedEH = _unit addEventHandler ["Killed", {call FUNC(moduleAmbientAnimEnd)}];
_unit setVariable [QGVAR(ambientAnimKilledEH), _killedEH];

// Add event handler to cancel animation if fired near and combat ready enabled
if (_combatReady) then {
    private _firedNearEH = _unit addEventHandler ["FiredNear", {call FUNC(moduleAmbientAnimEnd)}];
    _unit setVariable [QGVAR(ambientAnimFiredNearEH), _firedNearEH];
};
