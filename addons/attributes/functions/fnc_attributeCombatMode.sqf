/*
 * Author: mharis001
 * Initializes the "Combat Mode" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeCombatMode
 *
 * Public: No
 */
#include "script_component.hpp"

#define IDCS [IDC_COMBATMODE_BLUE, IDC_COMBATMODE_GREEN, IDC_COMBATMODE_WHITE, IDC_COMBATMODE_YELLOW, IDC_COMBATMODE_RED, IDC_COMBATMODE_DEFAULT]
#define COMBATMODES ["BLUE", "GREEN", "WHITE", "YELLOW", "RED", "NO CHANGE"]
#define COLORS [[1, 0, 0, 1], [1, 0, 0, 1], [1, 0, 0, 1], [1, 1, 1, 1], [1, 1, 1, 1], [1, 1, 1, 1]]

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

if (_entity isEqualType grpNull) then {
    private _ctrlDefault = _display displayCtrl IDC_COMBATMODE_DEFAULT;
    _ctrlDefault ctrlEnable false;
    _ctrlDefault ctrlShow false;
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

    private _combatMode = COMBATMODES select (IDCS find _activeIDC);
    _display setVariable [QGVAR(combatMode), _combatMode];
};

private _combatMode = if (_entity isEqualType grpNull) then {combatMode _entity} else {waypointCombatMode _entity};
private _activeIDC = IDCS select (COMBATMODES find toUpper _combatMode);

{
    private _ctrl = _display displayCtrl _x;
    private _color = COLORS select _forEachIndex;
    _ctrl ctrlSetActiveColor _color;

    if (_activeIDC == _x) then {
        [_ctrl, 1.2, 0] call BIS_fnc_ctrlSetScale;
    } else {
        _color set [3, 0.5];
    };

    _ctrl ctrlSetTextColor _color;
    _ctrl ctrlAddEventHandler ["ButtonClick", _fnc_onButtonClick];
} forEach IDCS;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _combatMode = _display getVariable QGVAR(combatMode);
    if (isNil "_combatMode") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

    if (_entity isEqualType grpNull) then {
        {
            [QEGVAR(common,setCombatMode), [_x, _combatMode], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    } else {
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_combatMode != "NO CHANGE"}) then {
                [QEGVAR(common,setCombatMode), [_group, _combatMode], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointCombatMode), [_x, _combatMode]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    };
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
