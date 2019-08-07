#include "script_component.hpp"
/*
 * Author: mharis001, 3Mydlo3
 * Allows Zeus to select a position or vehicle to teleport players to.
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
        curatorMouseOver params ["_type", "_entity"];

        if (_type isEqualTo "OBJECT" && {_entity isKindOf "AllVehicles"} && {!(_entity isKindOf "CAManBase")}) then {
            [_players, _entity] call EFUNC(common,teleportIntoVehicle);
        } else {
            {
                _x setPosASL _posASL;
            } forEach _players;
        };
    };
}, [], LSTRING(TeleportPlayers)] call EFUNC(common,getTargetPos);
