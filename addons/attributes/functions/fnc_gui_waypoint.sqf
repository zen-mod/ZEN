#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "waypoint" attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value (not used) <ANY>
 * 2: Value Info (not used) <ANY>
 * 3: Entity <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, _defaultValue, _valueInfo, _entity] call zen_attributes_fnc_gui_waypoint
 *
 * Public: No
 */

params ["_controlsGroup", "", "", "_entity"];

// Exit and display message if waypoint is attached to a vehicle
if (!isNull waypointAttachedVehicle _entity) exitWith {
    private _ctrlBackground = _display displayCtrl IDC_ATTRIBUTE_BACKGROUND;
    _ctrlBackground ctrlSetText localize "str_a3_rscattributewaypointtype_type";
};

// Get active waypoint types and create toolbox with appropriate number of rows
private _waypointTypes = uiNamespace getVariable QGVAR(waypointTypes) select {
    _entity call (_x select 4)
};

private _rows = ceil (count _waypointTypes / 3);
parsingNamespace setVariable [QEGVAR(common,rows), _rows];
parsingNamespace setVariable [QEGVAR(common,columns), 3];

private _ctrlToolbox = _display ctrlCreate [QEGVAR(common,RscToolbox), IDC_ATTRIBUTE_TOOLBOX, _controlsGroup];
_ctrlToolbox ctrlSetBackgroundColor [0, 0, 0, 0];
_ctrlToolbox ctrlSetPosition [0, POS_H(1), POS_W(26), POS_H(_rows)];
_ctrlToolbox ctrlCommit 0;

private _ctrlBackground = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_BACKGROUND;
_ctrlBackground ctrlSetPositionH POS_H(_rows);
_ctrlBackground ctrlCommit 0;

_controlsGroup ctrlSetPositionH POS_H(_rows + 1);
_controlsGroup ctrlCommit 0;

// Determine the waypoint type from the given entity
private _waypointType = waypointType _entity;
private _waypointScript = waypointScript _entity;

{
    _x params ["_name", "_tooltip", "_type", "_script"];

    private _index = _ctrlToolbox lbAdd toUpper _name;
    _ctrlToolbox lbSetTooltip [_index, _tooltip];
    _ctrlToolbox setVariable [str _index, [_type, _script]];

    if (_type == _waypointType && {_type != "SCRIPTED" || {_script == _waypointScript}}) then {
        _ctrlToolbox lbSetCurSel _index;
    };
} forEach _waypointTypes;

_ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlToolbox", "_index"];

    private _value = _ctrlToolbox getVariable str _index;
    private _controlsGroup = ctrlParentControlsGroup _ctrlToolbox;
    _controlsGroup setVariable [QGVAR(value), _value];
}];
