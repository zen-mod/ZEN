#include "script_component.hpp"
/*
 * Author: mharis001
 * Add an intel action to the given object.
 *
 * Arguments:
 * 0: Object <OBJECT>
 * 1: Share With (0 - Side, 1 - Group, 2 - Nobody) <NUMBER>
 * 2: Delete On Completion <BOOL>
 * 3: Action Type (0 - Hold Action, 1 - ACE Interaction Menu) <NUMBER>
 * 4: Action Text <STRING>
 * 5: Action Sounds <ARRAY>
 * 6: Action Duration <NUMBER>
 * 7: Intel Title <STRING>
 * 8: Intel Text <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object, 0, true, 0, "Pick Up Intel", 1, "Intel!", "Notes..."] call zen_modules_fnc_addIntelAction
 *
 * Public: No
 */

#define MAX_DISTANCE 3
#define MIN_SOUND_DELAY 1
#define MID_SOUND_DELAY 2
#define MAX_SOUND_DELAY 4

params ["_object", "_share", "_delete", "_actionType", "_actionText", "_actionSounds", "_duration", "_title", "_text"];

private _fnc_addIntel = {
    private _targets = switch (_share) do {
        case 0: {
            call CBA_fnc_players select {side group _x == side _unit}
        };
        case 1: {
            units _unit select {isPlayer _x}
        };
        case 2: {
            [_unit]
        };
    };

    // Send to message to curators that a player has found intel
    [
        QEGVAR(common,showMessage),
        [format [localize LSTRING(ModuleCreateIntel_PlayerFoundIntel), name _unit, _title]],
        allCurators
    ] call CBA_fnc_targetEvent;

    playSound "Beep_Target";

    [
        ["\a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa", 1.25],
        [localize LSTRING(ModuleCreateIntel_IntelFound)],
        true
    ] call CBA_fnc_notify;

    [QGVAR(addIntel), [_title, _text], _targets] call CBA_fnc_targetEvent;
};

// Removing previous action regardless of type to handle switching action types
private _actionID = _object getVariable QGVAR(intelActionID);

if (!isNil "_actionID") then {
    [_object, _actionID] call BIS_fnc_holdActionRemove;
};

[_object, 0, ["ACE_MainActions", QGVAR(intelAction)]] call ace_interact_menu_fnc_removeActionFromObject;

if (_actionType == 1 && {isClass (configFile >> "CfgPatches" >> "ace_interact_menu")}) then {
    private _action = [
        QGVAR(intelAction),
        _actionText,
        "\a3\ui_f\data\igui\cfg\simpletasks\types\documents_ca.paa",
        {
            params ["_object", "_unit", "_args"];
            _args params ["_title", "_text", "_share", "_delete", "_actionText", "_actionSounds", "_duration", "_fnc_addIntel"];

            if (_actionSounds isNotEqualTo []) then {
                _object setVariable [QGVAR(nextTimeForSound), CBA_missionTime];
            };

            [
                _duration,
                [_object, _unit, _title, _text, _actionSounds, _share, _delete, _fnc_addIntel],
                {
                    (_this select 0) params ["_object", "_unit", "_title", "_text", "_actionSounds", "_share", "_delete", "_fnc_addIntel"];

                    call _fnc_addIntel;

                    if (_delete) then {
                        deleteVehicle _object;
                    } else {
                        [_object, 0, ["ACE_MainActions", QGVAR(intelAction)]] call ace_interact_menu_fnc_removeActionFromObject;
                    };

                    _object setVariable [QGVAR(nextTimeForSound), nil];
                },
                {
                    (_this select 0) params ["_object"];

                    _object setVariable [QGVAR(nextTimeForSound), nil];
                },
                _actionText,
                {
                    (_this select 0) params ["_object", "", "", "", "_actionSounds"];

                    private _time = CBA_missionTime;
                    private _nextTimeForSound = _object getVariable [QGVAR(nextTimeForSound), _time];

                    if (_time > _nextTimeForSound) then {
                        playSound selectRandom _actionSounds;

                        private _nextDelay = random [MIN_SOUND_DELAY, MID_SOUND_DELAY, MAX_SOUND_DELAY];
                        _object setVariable [QGVAR(nextTimeForSound), _time + _nextDelay];
                    };

                    true
                }
            ] call ace_common_fnc_progressBar;
        },
        {true},
        {},
        [_title, _text, _share, _delete, _actionText, _actionSounds, _duration, _fnc_addIntel]
    ] call ace_interact_menu_fnc_createAction;

    [_object, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToObject;
} else {
    _actionID = [
        _object,
        _actionText,
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
        "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_search_ca.paa",
        QUOTE(_target distance _this < MAX_DISTANCE),
        QUOTE(_target distance _caller < MAX_DISTANCE),
        {
            params ["_object", "", "", "_args"];
            _args params ["", "", "_actionSounds"];

            if (_actionSounds isNotEqualTo []) then {
                _object setVariable [QGVAR(nextTickForSound), 1];
            };
        },
        {
            params ["_object", "", "", "_args", "_ticks", "_maxTicks"];
            _args params ["", "", "_actionSounds", "_duration"];

            private _nextTickForSound = _object getVariable [QGVAR(nextTickForSound), -1];

            if (_ticks == _nextTickForSound) then {
                playSound selectRandom _actionSounds;

                private _nextDelay = random [MIN_SOUND_DELAY, MID_SOUND_DELAY, MAX_SOUND_DELAY];
                _object setVariable [QGVAR(nextTickForSound), _ticks + ceil (_maxTicks  * _nextDelay / _duration)];
            };
        },
        {
            params ["_object", "_unit", "", "_args"];
            _args params ["_title", "_text", "", "", "_share", "_delete", "_fnc_addIntel"];

            call _fnc_addIntel;

            if (_delete) then {
                deleteVehicle _object;
            };

            _object setVariable [QGVAR(nextTickForSound), nil];
        },
        {
             params ["_object"];
            _object setVariable [QGVAR(nextTickForSound), nil];
        },
        [_title, _text, _actionSounds, _duration, _share, _delete, _fnc_addIntel],
        _duration,
        100,
        true,
        false
    ] call BIS_fnc_holdActionAdd;

    _object setVariable [QGVAR(intelActionID), _actionID];
};
