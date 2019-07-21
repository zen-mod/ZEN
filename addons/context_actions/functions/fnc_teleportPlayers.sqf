#include "script_component.hpp"
/*
 * Author: mharis001
 * Allows Zeus to select a position to teleport players to.
 *
 * Arguments:
 * N: Selected Objects <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player1, player2, player3] call zen_context_actions_fnc_teleportPlayers
 *
 * Public: No
 */

private _players = _this select {isPlayer _x};

[_players, {
    params ["_successful", "_players", "_posASL"];

    if (_successful) then {
        {
            _x setPosASL _posASL;
        } forEach _players;
    };
}, [], LSTRING(TeleportPlayers)] call EFUNC(common,getTargetPos);
