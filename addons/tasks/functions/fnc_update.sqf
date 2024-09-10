#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles creating/updating the task associated with the given logic.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Task Data <ARRAY>
 *   0: Owners <ARRAY>
 *   1: State <STRING>
 *   2: Show Destination <BOOL>
 *   3: Type <STRING>
 *   4: Title <STRING>
 *   5: Description <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic, _taskData] call zen_tasks_fnc_update
 *
 * Public: No
 */

params ["_logic", "_taskData"];
_taskData params ["_owners", "_state", "_showDestination", "_type", "_title", "_description"];

// Get the task ID associated with this module
private _taskID = _logic getVariable QGVAR(id);

// Generate a new task ID for this module if one does not exist yet
if (isNil "_taskID") then {
    if (isNil QGVAR(nextID)) then {
        GVAR(nextID) = 0;
    };

    _taskID = format [QGVAR(id_%1), GVAR(nextID)];
    _logic setVariable [QGVAR(id), _taskID];

    GVAR(nextID) = GVAR(nextID) + 1;

    // Delete incomplete tasks if the module is deleted
    _logic addEventHandler ["Deleted", {
        params ["_logic"];

        private _taskID = _logic getVariable QGVAR(id);
        if (_taskID call BIS_fnc_taskCompleted) exitWith {};

        _taskID call BIS_fnc_deleteTask;
    }];
};

private _newOwners = _owners select (_owners select 3);
private _oldOwners = _logic getVariable [QGVAR(owners), []];

// Use the module as the task's destination if needed
private _target = [objNull, _logic] select _showDestination;

// Create/update the task with the new paramters
[_taskID, _newOwners, [_description, _title, ""], [_target, true], _state, nil, nil, nil, _type] call BIS_fnc_setTask;

// Delete task for no longer active owners
private _ownersToRemove = _oldOwners - _newOwners;

if (_ownersToRemove isNotEqualTo []) then {
    [_taskID, _ownersToRemove] call BIS_fnc_deleteTask;
};

// Save new owners (task framework does not have a function get them)
_logic setVariable [QGVAR(owners), _newOwners];

// Disable simulation when the task is completed
private _enabled = _state in ["CREATED", "ASSIGNED"];
_logic enableSimulationGlobal _enabled;

// Broadcast new task data to clients
_logic setVariable [QGVAR(data), _taskData, true];
