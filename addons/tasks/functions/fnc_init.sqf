#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Custom Objective" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_tasks_fnc_init
 *
 * Public: No
 */

params ["_display", "_logic"];

_display setVariable [QGVAR(logic), _logic];

// Get the data of the task associated with the module
private _taskData = _logic getVariable [QGVAR(data), [[[], [], [], 0], "CREATED", true, "default", "", ""]];
_taskData params ["_owners", "_state", "_showDestination", "_type", "_title", "_description"];

// Initialize owners control
private _ctrlOwners = _display displayCtrl IDC_TASK_OWNERS;
[_ctrlOwners, +_owners] call EFUNC(common,initOwnersControl);

// Select the current task state
private _ctrlState = _display displayCtrl IDC_TASK_STATE;
_ctrlState lbSetCurSel (TASK_STATES find _state);

// Select the current task destination
private _ctrlDestination = _display displayCtrl IDC_TASK_DESTINATION;
_ctrlDestination lbSetCurSel parseNumber _showDestination;

// Add task types to the combo box
private _ctrlType = _display displayCtrl IDC_TASK_TYPE;

{
    private _name = getText (_x >> "displayName");

    if (_name != "") then {
        private _index = _ctrlType lbAdd _name;
        _ctrlType lbSetPicture [_index, getText (_x >> "icon")];
        _ctrlType lbSetData [_index, configName _x];
    };
} forEach configProperties [configFile >> "CfgTaskTypes", "isClass _x"];

lbSort _ctrlType;

// Select the current task type
for "_index" from 0 to (lbSize _ctrlType - 1) do {
    if (_ctrlType lbData _index == _type) exitWith {
        _ctrlType lbSetCurSel _index;
    };
};

// Update title and description edit boxes when an option is selected in the history combo box
private _ctrlHistory = _display displayCtrl IDC_TASK_HISTORY;
_ctrlHistory ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlHistory", "_index"];

    private _display = ctrlParent _ctrlHistory;
    (_ctrlHistory getVariable str _index) params ["_title", "_description"];

    private _ctrlTitle = _display displayCtrl IDC_TASK_TITLE;
    _ctrlTitle ctrlSetText _title;

    private _ctrlDescription = _display displayCtrl IDC_TASK_DESCRIPTION;
    _ctrlDescription ctrlSetText _description;
}];

// Add new/current default option to reset the title and description
private _defaultOption = [
    "STR_A3_RscAttributeTaskDescription_Current",
    "STR_A3_RscAttributeTaskDescription_New"
] select (_title == "" && {_description == ""});

_ctrlHistory lbAdd localize _defaultOption;
_ctrlHistory setVariable ["0", [_title, _description]];

// Add saved titles and descriptions to history combo box
{
    _x params ["_title", "_description"];

    private _index = _ctrlHistory lbAdd _title;
    _ctrlHistory setVariable [str _index, [_title, _description]];
} forEach (profileNamespace getVariable [VAR_HISTORY, []]);

// Initially select the new/current option, this will also update the title and description edit boxes
_ctrlHistory lbSetCurSel 0;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _logic = _display getVariable QGVAR(logic);

    private _ctrlOwners = _display displayCtrl IDC_TASK_OWNERS;
    private _owners = _ctrlOwners getVariable QEGVAR(common,value);

    private _ctrlState = _display displayCtrl IDC_TASK_STATE;
    private _state = TASK_STATES select lbCurSel _ctrlState;

    private _ctrlDestination = _display displayCtrl IDC_TASK_DESTINATION;
    private _showDestination = lbCurSel _ctrlDestination == 1;

    private _ctrlType = _display displayCtrl IDC_TASK_TYPE;
    private _type = _ctrlType lbData lbCurSel _ctrlType;

    private _ctrlTitle = _display displayCtrl IDC_TASK_TITLE;
    private _title = ctrlText _ctrlTitle;

    private _ctrlDescription = _display displayCtrl IDC_TASK_DESCRIPTION;
    private _description = ctrlText _ctrlDescription;

    // Save title and description to history
    private _history = profileNamespace getVariable [VAR_HISTORY, []];
    _history deleteAt (_history find [_title, _description]);

    reverse _history;
    _history pushBack [_title, _description];
    reverse _history;

    _history resize (count _history min MAX_HISTORY_SIZE);

    profileNamespace setVariable [VAR_HISTORY, _history];

    // Send task data to server to handle creating/updating the task
    private _taskData = [_owners, _state, _showDestination, _type, _title, _description];
    [QGVAR(update), [_logic, _taskData]] call CBA_fnc_serverEvent;
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
