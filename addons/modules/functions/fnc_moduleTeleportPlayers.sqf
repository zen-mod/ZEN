#include "script_component.hpp"
/*
 * Author: mharis001, Kex
 * Zeus module function to teleport players.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleTeleportPlayers
 *
 * Public: No
 */

params ["_logic"];

[LSTRING(ModuleTeleportPlayers), [
    ["OWNERS:NOTITLE", "", [], true],
    ["TOOLBOX:YESNO", [LSTRING(ModuleTeleportPlayers_IncludeVehicles), LSTRING(ModuleTeleportPlayers_IncludeVehicles_Tooltip)], false]
], {
    params ["_values", "_args"];
    _values params ["_owners", "_includeVehicles"];
    _args params ["_position", "_vehicle"];

    // Only use players from the active tab in the owners control
    private _players = [_owners select (_owners select 3)] call EFUNC(common,getPlayers);

    if (isNull _vehicle || {fullCrew [_vehicle, "", true] isEqualTo []}) then {
        if (_includeVehicles) then {
            _players = _players apply {vehicle _x};
            _players = _players arrayIntersect _players;
        };

        // Ensure proper spacing among units
        private _gridSize = TELEPORT_SPACING + 0.5 * selectMax (_players apply {sizeOf typeOf _x});
        private _nGrid = ceil sqrt count _players;
        private _offset = _gridSize * floor (_nGrid / 2);
        private _startPos = _position vectorDiff [_offset, _offset, 0];
        private _positions = [];

        for "_i" from 0 to (_nGrid - 1) do {
            for "_j" from 0 to (_nGrid - 1) do {
                _positions pushBack (_startPos vectorAdd [_i * _gridSize, _j * _gridSize, 0]);
            };
        };

        {
            private _position = _positions select _forEachIndex;

            // Special handling for aircraft that are flying
            // Without "FLY" they will be teleported to the ground and explode
            // Manually set their velocity to prevent them from falling out of the sky
            if (_x isKindOf "Air" && {getPosATL _x select 2 > 2}) then {
                _x setVehiclePosition [_position, [], 0, "FLY"];
                [QEGVAR(common,setVelocity), [_x, velocity _x], _x] call CBA_fnc_targetEvent;
            } else {
                // Need special handling for players in vehicles
                // Without this they are teleported back inside the vehicle
                if (_x isKindOf "CAManBase" && {vehicle _x != _x}) then {
                    [QGVAR(teleportOutOfVehicle), [_x, _position], _x] call CBA_fnc_targetEvent;
                } else {
                    _x setVehiclePosition [_position, [], 0, "NONE"];
                };
            };
        } forEach _players;
    } else {
        [_players, _vehicle] call EFUNC(common,teleportIntoVehicle);
    };
}, {}, [getPosATL _logic, attachedTo _logic]] call EFUNC(dialog,create);

deleteVehicle _logic;
