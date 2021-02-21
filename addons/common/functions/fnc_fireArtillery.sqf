#include "script_component.hpp"
/*
 * Author: mharis001
 * Makes the given artillery unit fire on the given position.
 *
 * Arguments:
 * 0: Artillery Unit <OBJECT>
 * 1: Position <ARRAY|OBJECT|STRING>
 *   - in AGL format, or a Map Grid when STRING
 * 2: Spread <NUMBER>
 * 3: Magazine <STRING>
 * 4: Number of Rounds <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_unit, _position, 0, _magazine, 1] call zen_common_fnc_fireArtillery
 *
 * Public: No
 */

#define LOW_SPREAD_THRESHOLD 25

params [["_unit", objNull, [objNull]], ["_position", [0, 0, 0], [[], objNull, ""], 3], ["_spread", 0, [0]], ["_magazine", "", [""]], ["_rounds", 1, [0]]];

if (_unit call EFUNC(common,isVLS)) exitWith {
    _this call EFUNC(common,fireVLS);
};

if (_position isEqualType objNull) then {
    _position = ASLtoAGL getPosASL _position;
};

if (_position isEqualType "") then {
    _position = [_position, true] call CBA_fnc_mapGridToPos;
};

// For small spread values, use doArtilleryFire directly to avoid delay
// Between firing caused by using doArtilleryFire one round at a time
if (_spread <= LOW_SPREAD_THRESHOLD) exitWith {
    _unit doArtilleryFire [_position, _magazine, _rounds];
};

[{
    params ["_unit", "_position", "_spread", "_magazine", "_rounds"];

    if (unitReady _unit) then {
        _unit doArtilleryFire [[_position, _spread] call CBA_fnc_randPos, _magazine, 1];
        _rounds = _rounds - 1;
        _this set [4, _rounds];
    };

    _rounds <= 0 || {!alive _unit} || {!alive gunner _unit}
}, {}, [_unit, _position, _spread, _magazine, _rounds]] call CBA_fnc_waitUntilAndExecute;
