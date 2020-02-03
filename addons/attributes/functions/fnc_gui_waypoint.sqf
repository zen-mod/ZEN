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

private _ctrlToolbox = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_TOOLBOX;

// Determine the waypoint type from the given entity
private _waypointType   = waypointType _entity;
private _waypointScript = waypointScript _entity;
private _waypointTypes  = uiNamespace getVariable QGVAR(waypointTypes);

{
    _x params ["_name", "_type", "_script"];

    private _index = _ctrlToolbox lbAdd _name;
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
