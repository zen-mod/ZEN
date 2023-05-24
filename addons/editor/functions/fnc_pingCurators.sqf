#include "script_component.hpp"
/*
 * Author: Ampersand, mharis001
 * Pings curators to the given target object or position.
 *
 * Arguments:
 * 0: Curator <OBJECT>
 * 1: Ping Target <OBJECT|ARRAY>
 *   - Positions must be in AGL format.
 * 2: Curator's Name <STRING> (default: "")
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _target] call zen_editor_fnc_pingCurators
 *
 * Public: No
 */

#define PING_DRAW_TIME 1.2
#define PING_DRAW_ICON "\a3\ui_f_curator\data\logos\arma3_curator_eye_512_ca.paa"

#define PING_SCALE_DELAY 0.1
#define PING_SCALE_END 0.7
#define PING_SCALE_MIN 0.8
#define PING_SCALE_MAX 1

#define PING_ALPHA_DELAY 0.8
#define PING_ALPHA_END 1.2
#define PING_ALPHA_MIN 0
#define PING_ALPHA_MAX 1

if (isNull curatorCamera) exitWith {};

params ["_curator", "_target", ["_name", ""]];

GVAR(pingTarget) = _target;

// Draw 3D icon to indicate the pinged object or position
if (isNil QGVAR(pingDrawMap)) then {
    GVAR(pingDrawMap) = createHashMap;
};

GVAR(pingDrawMap) set [hashValue _curator, [_target, _name, CBA_missionTime]];

if (isNil QGVAR(pingDraw3D)) then {
    GVAR(pingDraw3D) = addMissionEventHandler ["Draw3D", {
        {
            GVAR(pingDrawMap) get _x params ["_target", "_name", "_startTime"];

            private _elapsedTime = CBA_missionTime - _startTime;

            if (_elapsedTime > PING_DRAW_TIME) then {
                GVAR(pingDrawMap) deleteAt _x;
            } else {
                if (_target isEqualType objNull) then {
                    _target = unitAimPositionVisual _target;
                };

                private _scale = linearConversion [
                    PING_SCALE_DELAY,
                    PING_SCALE_END,
                    _elapsedTime,
                    PING_SCALE_MIN,
                    PING_SCALE_MAX,
                    true
                ];

                private _alpha = linearConversion [
                    PING_ALPHA_DELAY,
                    PING_ALPHA_END,
                    _elapsedTime,
                    PING_ALPHA_MAX,
                    PING_ALPHA_MIN,
                    true
                ];

                // Using two drawIcon3D calls to prevent moving the name text as the icon grows
                drawIcon3D [PING_DRAW_ICON, [1, 1, 1, _alpha], _target, _scale, _scale, 0];
                drawIcon3D ["", [1, 1, 1, _alpha], _target, PING_SCALE_MAX, PING_SCALE_MAX, 0, _name];
            };
        } forEach keys GVAR(pingDrawMap);

        if (GVAR(pingDrawMap) isEqualTo createHashMap) then {
            removeMissionEventHandler [_thisEvent, _thisEventHandler];
            GVAR(pingDraw3D) = nil;
        };
    }];
};

// Play sound (unique for each curator based on name)
private _sounds = getArray (configFile >> "CfgCurator" >> "soundsPing");
private _random = 0;

{
    _random = _random + _x;
} forEach toArray _name;

playSound [_sounds select (_random % count _sounds), true];
