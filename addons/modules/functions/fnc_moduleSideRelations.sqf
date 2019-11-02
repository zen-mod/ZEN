#include "script_component.hpp"
/*
 * Author: mharis001
 * Changes side relations and plays radio messages.
 *
 * Arguments:
 * 0: Side 1 <SIDE>
 * 1: Side 2 <SIDE>
 * 2: Friend value <NUMBER>
 * 3: Play radio message <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [west, east, 0, false] call zen_modules_fnc_moduleSideRelations
 *
 * Public: No
 */

params ["_side1", "_side2", "_friendValue", "_radio"];
TRACE_1("Module Side Relations",_this);

// Change side relations
[QEGVAR(common,setFriend), [_side1, _side2, _friendValue]] call CBA_fnc_serverEvent;
[QEGVAR(common,setFriend), [_side2, _side1, _friendValue]] call CBA_fnc_serverEvent;

// Play radio message
if (_radio) then {
    private _message = ["SentGenBaseSideEnemy%1", "SentGenBaseSideFriendly%1"] select _friendValue;

    [QGVAR(sayMessage), [_side1, format [_message, _side2], "side"]] call CBA_fnc_globalEvent;
    [QGVAR(sayMessage), [_side2, format [_message, _side1], "side"]] call CBA_fnc_globalEvent;
};
