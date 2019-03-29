/*
 * Author: mharis001
 * Starts configuring the doors of a building.
 *
 * Arguments:
 * 0: Building <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [building] call zen_doors_fnc_configure
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_building"];

// Exit if the building has no doors
private _doors = [_building] call FUNC(getDoors);

if (_doors isEqualTo []) exitWith {
    [LSTRING(NoDoors)] call EFUNC(common,showMessage);
};

// Create the door button controls
private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _controls = [];

{
    private _control = _display ctrlCreate [QGVAR(RscActivePicture), -1];
    _control ctrlAddEventHandler ["ButtonClick", {call FUNC(setState)}];
    _control setVariable [QGVAR(building), _building];
    _control setVariable [QGVAR(door), _forEachIndex + 1];

    _controls pushBack _control;
} forEach _doors;

// Add PFH to update controls
[FUNC(updatePFH), 0, [_building, _doors, _controls]] call CBA_fnc_addPerFrameHandler;
