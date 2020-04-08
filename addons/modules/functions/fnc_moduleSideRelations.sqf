#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to change the relationship of the given sides.
 *
 * Arguments:
 * 0: Side 1 <SIDE>
 * 1: Side 2 <SIDE>
 * 2: Friendly <BOOL>
 * 3: Play Radio Message <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [west, east, true, false] call zen_modules_fnc_moduleSideRelations
 *
 * Public: No
 */

params ["_side1", "_side2", "_friendly", "_radio"];

if (_radio) then {
    private _message = ["SentGenBaseSideEnemy%1", "SentGenBaseSideFriendly%1"] select _friendly;

    [QGVAR(sayMessage), [_side1, format [_message, _side2], "side"]] call CBA_fnc_globalEvent;
    [QGVAR(sayMessage), [_side2, format [_message, _side1], "side"]] call CBA_fnc_globalEvent;
};

_friendly = parseNumber _friendly;

[QEGVAR(common,setFriend), [_side1, _side2, _friendly]] call CBA_fnc_serverEvent;
[QEGVAR(common,setFriend), [_side2, _side1, _friendly]] call CBA_fnc_serverEvent;
