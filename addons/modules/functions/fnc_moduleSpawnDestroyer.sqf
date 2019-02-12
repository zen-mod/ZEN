/*
 * Author: mharis001
 * Zeus module function to spawn the USS Liberty destroyer.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleSpawnDestroyer
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic"];

[_logic, {
    [QEGVAR(common,execute), [{
        params ["_logic"];

        private _position = getPosASL _logic;
        private _direction = (getDir _logic + 180) % 360; // Opposite direction

        private _destroyer = createVehicle ["Land_Destroyer_01_base_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
        _destroyer setPosASL _position;
        _destroyer setVectorDirAndUp [[sin _direction, cos _direction, 0], [0, 0, 1]];

        private _jipID = [QGVAR(destroyerInit), _destroyer] call CBA_fnc_globalEventJIP;
        [_jipID, _destroyer] call CBA_fnc_removeGlobalEventJIP;

        [QEGVAR(common,addObjects), [[_destroyer]]] call CBA_fnc_serverEvent;

        {
            deleteVehicle _x;
        } forEach nearestObjects [[0, 0, 0], ["Land_Destroyer_01_Boat_Rack_01_Base_F", "Land_Destroyer_01_hull_base_F", "ShipFlag_US_F"], 300, true];

        _destroyer addEventHandler ["Deleted", {
            params ["_destroyer"];

            {
                _x params ["_part"];
                deleteVehicle _part;
            } forEach (_destroyer getVariable ["bis_carrierParts", []]);
        }];

        deleteVehicle _logic;
    }, _this]] call CBA_fnc_serverEvent;
}, 222.2, 44.4] call EFUNC(common,spawnLargeObject);
