#include "script_component.hpp"
/*
 * Author: mharis001
 * Ejects passengers of the given vehicle one at a time.
 * If the vehicle is flying, the units will be given parachutes.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [vehicle player] call zen_common_fnc_ejectPassengers
 *
 * Public: No
 */

#define PARACHUTE_HEIGHT 30
#define PARACHUTE_DELAY 1.5
#define PASSENGER_DELAY 1.2

params ["_vehicle"];

[{
    params ["_vehicle", "_nextEject"];

    // Only eject passengers (units assigned to "cargo" role)
    private _passengers = crew _vehicle select {
        alive _x && {assignedVehicleRole _x param [0, ""] == "cargo"}
    };

    // Small delay between each unit, all units do not immediately get out
    if (CBA_missionTime >= _nextEject) then {
        private _unit = _passengers deleteAt 0;
        [QGVAR(unassignVehicle), _unit, _unit] call CBA_fnc_targetEvent;

        // If the vehicle is currently high enough, create a parachute for the unit
        if (ASLtoAGL getPosASL _vehicle select 2 > PARACHUTE_HEIGHT) then {
            moveOut _unit;

            [{
                params ["_unit"];

                private _parachute = createVehicle ["Steerable_Parachute_F", _unit, [], 0, "NONE"];
                _parachute setDir getDir _unit;
                _parachute setVelocity velocity _unit;

                [QGVAR(moveInDriver), [_unit, _parachute], _unit] call CBA_fnc_targetEvent;
            }, _unit, PARACHUTE_DELAY] call CBA_fnc_waitAndExecute;
        };

        _this set [1, CBA_missionTime + PASSENGER_DELAY];
    };

    !alive _vehicle || {_passengers isEqualTo []}
}, {}, [_vehicle, CBA_missionTime]] call CBA_fnc_waitUntilAndExecute;
