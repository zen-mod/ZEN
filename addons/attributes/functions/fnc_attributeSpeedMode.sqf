#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Speed Mode" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeSpeedMode
 *
 * Public: No
 */

#define IDCS [IDC_SPEEDMODE_LIMITED, IDC_SPEEDMODE_NORMAL, IDC_SPEEDMODE_FULL, IDC_SPEEDMODE_DEFAULT]
#define SPEED_MODES ["LIMITED", "NORMAL", "FULL", "UNCHANGED"]

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

if (_entity isEqualType grpNull) then {
    private _ctrlDefault = _display displayCtrl IDC_SPEEDMODE_DEFAULT;
    _ctrlDefault ctrlEnable false;
    _ctrlDefault ctrlShow false;
};

private _fnc_onButtonClick = {
    params ["_activeCtrl"];

    private _display = ctrlParent _activeCtrl;
    private _activeIDC = ctrlIDC _activeCtrl;

    {
        private _ctrl = _display displayCtrl _x;
        private _color = [1, 1, 1, 0.5];
        private _scale = 1;

        if (_activeIDC == _x) then {
            _color set [3, 1];
            _scale = 1.2;
        };

        _ctrl ctrlSetTextColor _color;
        [_ctrl, _scale, 0.1] call BIS_fnc_ctrlSetScale;
    } forEach IDCS;

    private _speedMode = SPEED_MODES select (IDCS find _activeIDC);
    _display setVariable [QGVAR(speedMode), _speedMode];
};

private _speedMode = if (_entity isEqualType grpNull) then {speedMode _entity} else {waypointSpeed _entity};
private _activeIDC = IDCS select (SPEED_MODES find toUpper _speedMode);

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["ButtonClick", _fnc_onButtonClick];

    if (_activeIDC == _x) then {
        _ctrl ctrlSetTextColor [1, 1, 1, 1];
        [_ctrl, 1.2, 0] call BIS_fnc_ctrlSetScale;
    };
} forEach IDCS;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _speedMode = _display getVariable QGVAR(speedMode);
    if (isNil "_speedMode") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

    if (_entity isEqualType grpNull) then {
        {
            [QEGVAR(common,setSpeedMode), [_x, _speedMode], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    } else {
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_speedMode != "UNCHANGED"}) then {
                [QEGVAR(common,setSpeedMode), [_group, _speedMode], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointSpeed), [_x, _speedMode]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    };
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
