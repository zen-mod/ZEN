#include "script_component.hpp"
/*
 * Author: 3Mydlo3
 * Teleports the given units into the given vehicle.
 * Will only teleport if there is enough space in the vehicle for all units.
 *
 * Arguments:
 * 0: Units <ARRAY>
 * 1: Vehicle <OBJECT>
 *
 * Return Value:
 * Successful <BOOL>
 *
 * Example:
 * [_units, _vehicle] call zen_common_fnc_teleportIntoVehicle
 *
 * Public: No
 */

params ["_units", "_vehicle"];

private _success = false;

private _freeCargoSpace = {(_x select 0) isEqualTo objNull} count fullCrew [_vehicle, "", true];
private _unitsNotInTargetVehicle = _units select {!(_x in _vehicle)};
private _unitsCount = count _unitsNotInTargetVehicle;

if (_unitsCount <= _freeCargoSpace) then {
    {
        _x moveInAny _vehicle;
    } forEach _unitsNotInTargetVehicle;
    _success = true;
} else {
    [LSTRING(NotEnoughSpaceInVehicle), _unitsCount, _freeCargoSpace] call EFUNC(common,showMessage);
};

_success
