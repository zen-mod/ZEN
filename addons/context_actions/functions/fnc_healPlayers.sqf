/*
 * Author: 3Mydlo3
 * Heals players in given selection. Works for players in vehicles.
 *
 * Arguments:
 * N: Selected Objects <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player1, player2, player3] call zen_context_actions_fnc_healPlayers
 *
 * Public: No
 */
#include "script_component.hpp"

private _units = [];
{
    _units append crew _x;
} forEach _this;

{
    if (isPlayer _x) then {
        [_x] call EFUNC(common,healUnit);
    };
} forEach _units;
