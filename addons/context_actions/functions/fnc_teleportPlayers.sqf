#include "script_component.hpp"
/*
 * Author: mharis001, 3Mydlo3
 * Allows Zeus to select a position or vehicle to teleport players to.
 *
 * Arguments:
 * N: Objects <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_object] call zen_context_actions_fnc_teleportPlayers
 *
 * Public: No
 */

private _players = _this select {isPlayer _x};

[_players, {
    params ["_successful", "_players", "_position"];

    if (_successful) then {
        curatorMouseOver params ["_type", "_entity"];

        if (_type == "OBJECT" && {_entity isKindOf "AllVehicles"} && {!(_entity isKindOf "CAManBase")}) then {
            [_players, _entity] call EFUNC(common,teleportIntoVehicle);
        } else {
            if (count _players > 1) then {
                // setVehiclePosition places units on surface directly below position
                // Sometimes this will be the second surface below the selected position
                // Adding a small vertical offset allows units to be teleported consistently onto surfaces such as rooftops
                _position = ASLtoATL _position vectorAdd [0, 0, 0.1];

                {
                    _x setVehiclePosition [_position, [], 0, "NONE"];
                } forEach _players;
            } else {
                // Teleport to exact position if there is only one unit, no need to prevent collisions
                (_players select 0) setPosASL _position;
            };
        };
    };
}, [], LSTRING(TeleportPlayers)] call EFUNC(common,selectPosition);
