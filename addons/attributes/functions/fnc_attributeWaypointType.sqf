#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Waypoint Type" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeWaypointType
 *
 * Public: No
 */

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _ctrlToolbox = _display displayCtrl IDC_WAYPOINTTYPE_TOOLBOX;

if (isNull waypointAttachedVehicle _entity) then {
    private _fnc_onToolBoxSelChanged = {
        params ["_ctrlToolbox", "_index"];
        private _display = ctrlParent _ctrlToolbox;
        _display setVariable [QGVAR(waypointType), _index];
    };

    private _waypointType = waypointType _entity;
    private _waypointScript = waypointScript _entity;

    private _waypointTypes = uiNamespace getVariable QGVAR(waypointTypes);

    private _index = _waypointTypes findIf {
        _x params ["", ["_type", ""], ["_script", ""]];
        _type == _waypointType && {_type != "SCRIPTED" || {_script == _waypointScript}}
    };

    {
        _ctrlToolbox lbAdd (_x select 0);
    } forEach _waypointTypes;

    _ctrlToolbox lbSetCurSel (_index max 0);
    _ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", _fnc_onToolBoxSelChanged];
} else {
    private _ctrlBackground = _display displayCtrl IDC_WAYPOINTTYPE_BACKGROUND;
    _ctrlBackground ctrlSetText localize "str_a3_rscattributewaypointtype_type";

    _ctrlToolbox ctrlEnable false;
    _ctrlToolbox ctrlShow false;
};

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _index = _display getVariable QGVAR(waypointType);
    if (isNil "_index") exitWith {};

    private _waypointTypes = uiNamespace getVariable QGVAR(waypointTypes);
    (_waypointTypes select _index) params ["", ["_type", ""], ["_script", ""]];

    {
        _x setWaypointType _type;
        if (_type == "SCRIPTED") then {_x setWaypointScript _script};
    } forEach SELECTED_WAYPOINTS;
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
