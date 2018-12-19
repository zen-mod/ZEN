/*
 * Author: mharis001
 * Initializes the "Behaviour" Zeus attribute.
 *
 * Arguments:
 * 0: Attribute controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_attributeBehaviour
 *
 * Public: No
 */
#include "script_component.hpp"

#define IDCS [IDC_ATTRIBUTEBEHAVIOUR_CARELESS, IDC_ATTRIBUTEBEHAVIOUR_SAFE, IDC_ATTRIBUTEBEHAVIOUR_AWARE, IDC_ATTRIBUTEBEHAVIOUR_COMBAT, IDC_ATTRIBUTEBEHAVIOUR_STEALTH, IDC_ATTRIBUTEBEHAVIOUR_DEFAULT]
#define BEHAVIOURS ["CARELESS", "SAFE", "AWARE", "COMBAT", "STEALTH", "UNCHANGED"]
#define COLORS [[1, 1, 1, 1], [0, 1, 0, 1], [1, 1, 0, 1], [1, 0, 0, 1], [0, 1, 1, 1], [1, 1, 1, 1]]

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

_control ctrlRemoveAllEventHandlers "SetFocus";

if (_entity isEqualType grpNull) then {
    private _ctrlDefault = _display displayCtrl IDC_ATTRIBUTEBEHAVIOUR_DEFAULT;
    _ctrlDefault ctrlEnable false;
    _ctrlDefault ctrlShow false;

    {
        private _ctrl = _display displayCtrl _x;
        _ctrl ctrlSetPosition [(12.25 + _forEachIndex * 2.5) * GUI_GRID_W, 0.5 * GUI_GRID_H];
        _ctrl ctrlCommit 0;
    } forEach IDCS;
};

private _fnc_onButtonClick = {
    params ["_activeCtrl"];

    private _display = ctrlParent _activeCtrl;
    private _activeIDC = ctrlIDC _activeCtrl;

    {
        private _ctrl = _display displayCtrl _x;
        private _color = COLORS select _forEachIndex;
        private _scale = 1;

        if (_activeIDC == _x) then {
            _scale = 1.2;
        } else {
            _color set [3, 0.5];
        };

        _ctrl ctrlSetTextColor _color;
        [_ctrl, _scale, 0.1] call BIS_fnc_ctrlSetScale;
    } forEach IDCS;

    private _behaviour = BEHAVIOURS select (IDCS find _activeIDC);
    _display setVariable [QGVAR(behaviour), _behaviour];
};

private _behaviour = if (_entity isEqualType grpNull) then {behaviour leader _entity} else {waypointBehaviour _entity};
private _activeIDC = IDCS select (BEHAVIOURS find toUpper _behaviour);

{
    private _ctrl = _display displayCtrl _x;
    private _color = COLORS select _forEachIndex;
    _ctrl ctrlSetActiveColor _color;
    _color set [3, 0.5];

    if (_activeIDC == _x) then {
        [_ctrl, 1.2, 0] call BIS_fnc_ctrlSetScale;
        _color set [3, 1];
    };

    _ctrl ctrlSetTextColor _color;
    _ctrl ctrlAddEventHandler ["ButtonClick", _fnc_onButtonClick];
} forEach IDCS;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _behaviour = _display getVariable QGVAR(behaviour);
    if (isNil "_behaviour") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (_entity isEqualType grpNull) then {
        {
            [QEGVAR(common,setBehaviour), [_x, _behaviour], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    } else {
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_behaviour != "UNCHANGED"}) then {
                [QEGVAR(common,setBehaviour), [_group, _behaviour], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointBehaviour), [_x, _behaviour]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    };
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
