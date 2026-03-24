#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to spawn the USS Freedom aircraft carrier.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleSpawnCarrier
 *
 * Public: No
 */

params ["_logic"];

[_logic, {
    [QEGVAR(common,execute), [{
        params ["_logic"];

        private _position = getPosASL _logic;
        private _direction = (getDir _logic + 180) % 360; // Opposite direction

        private _carrier = createVehicle ["Land_Carrier_01_base_F", [0, 0, 0], [], 0, "CAN_COLLIDE"];
        _carrier setPosASL _position;
        _carrier setVectorDirAndUp [[sin _direction, cos _direction, 0], [0, 0, 1]];

        private _jipID = [QGVAR(carrierInit), _carrier] call CBA_fnc_globalEventJIP;
        [_jipID, _carrier] call CBA_fnc_removeGlobalEventJIP;

        [_carrier] call EFUNC(common,updateEditableObjects);

        {
            deleteVehicle _x;
        } forEach nearestObjects [[0, 0, 0], ["Land_Carrier_01_hull_GEO_Base_F", "Land_Carrier_01_hull_base_F", "DynamicAirport_01_F"], 300, true];

        _carrier addEventHandler ["Deleted", {
            params ["_carrier"];

            {
                _x params ["_part"];
                deleteVehicle _part;
            } forEach (_carrier getVariable ["bis_carrierParts", []]);
        }];

        deleteVehicle _logic;
    }, _this]] call CBA_fnc_serverEvent;
}, 387.7, 100.8] call EFUNC(common,spawnLargeObject);
