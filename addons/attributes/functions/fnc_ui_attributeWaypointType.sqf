/*
 * Author: mharis001
 * Initializes the "Waypoint Type" Zeus attribute.
 *
 * Arguments:
 * 0: Attribute controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_ui_attributeWaypointType
 *
 * Public: No
 */
#include "script_component.hpp"

#define WAYPOINT_TYPES ["MOVE", "CYCLE", "SAD", "HOLD", "SENTRY", "GETOUT", "UNLOAD", "TR UNLOAD", ["SCRIPTED", "a3\functions_f\waypoints\fn_wpLand.sqf"], "HOOK", "UNHOOK", ["SCRIPTED", "a3\functions_f_orange\waypoints\fn_wpDemine.sqf"]]

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

_control ctrlRemoveAllEventHandlers "SetFocus";

private _ctrlToolbox = _display displayCtrl IDC_ATTRIBUTEWAYPOINTTYPE_TOOLBOX;

if (isNull waypointAttachedVehicle _entity) then {
    private _fnc_onToolBoxSelChanged = {
        params ["_ctrlToolbox", "_index"];
        private _display = ctrlParent _ctrlToolbox;
        _display setVariable [QGVAR(waypointType), _index];
    };

    private _waypointType = waypointType _entity;
    private _waypointScript = waypointScript _entity;

    private _index = WAYPOINT_TYPES findIf {
        _x params [["_type", ""], ["_script", ""]];
        _type == _waypointType && {_type != "SCRIPTED" || {_script == _waypointScript}}
    };

    _ctrlToolbox lbSetCurSel _index;
    _ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", _fnc_onToolBoxSelChanged];
} else {
    private _ctrlBackground = _display displayCtrl IDC_ATTRIBUTEWAYPOINTTYPE_BACKGROUND;
    _ctrlBackground ctrlSetText localize "str_a3_rscattributewaypointtype_type";

    _ctrlToolbox ctrlEnable false;
    _ctrlToolbox ctrlShow false;
};

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _index = _display getVariable QGVAR(waypointType);
    if (isNil "_index") exitWith {};

    (WAYPOINT_TYPES select _index) params [["_type", ""], ["_script", ""]];

    {
        _x setWaypointType _type;
        if (_type == "SCRIPTED") then {_x setWaypointScript _script};
    } forEach (curatorSelected select 2);
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
