/*
 * Author: mharis001
 * Initializes the "Formation" Zeus attribute.
 *
 * Arguments:
 * 0: Attribute controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_ui_attributeFormation
 *
 * Public: No
 */
#include "script_component.hpp"

#define IDCS [IDC_ATTRIBUTEFORMATION_WEDGE, IDC_ATTRIBUTEFORMATION_VEE, IDC_ATTRIBUTEFORMATION_LINE, IDC_ATTRIBUTEFORMATION_COLUMN, IDC_ATTRIBUTEFORMATION_FILE, IDC_ATTRIBUTEFORMATION_STAGCOLUMN, IDC_ATTRIBUTEFORMATION_ECHLEFT, IDC_ATTRIBUTEFORMATION_ECHRIGHT, IDC_ATTRIBUTEFORMATION_DIAMOND, IDC_ATTRIBUTEFORMATION_DEFAULT]
#define FORMATIONS ["WEDGE", "VEE", "LINE", "COLUMN", "FILE", "STAG COLUMN", "ECH LEFT", "ECH RIGHT", "DIAMOND", "NO CHANGE"]

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

_control ctrlRemoveAllEventHandlers "SetFocus";

if (_entity isEqualType grpNull) then {
    private _ctrlDefault = _display displayCtrl IDC_ATTRIBUTEFORMATION_DEFAULT;
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

    private _formation = FORMATIONS select (IDCS find _activeIDC);
    _display setVariable [QGVAR(formation), _formation];
};

private _formation = if (_entity isEqualType grpNull) then {formation _entity} else {waypointFormation _entity};
private _activeIDC = IDCS select (FORMATIONS find toUpper _formation);

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
    private _formation = _display getVariable QGVAR(formation);
    if (isNil "_formation") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (_entity isEqualType grpNull) then {
        {
            [QEGVAR(common,setFormation), [_x, _formation], _x] call CBA_fnc_targetEvent;
        } forEach SELECTED_GROUPS;
    } else {
        {
            _x params ["_group", "_waypointID"];

            if (currentWaypoint _group == _waypointID && {_formation != "NO CHANGE"}) then {
                [QEGVAR(common,setFormation), [_group, _formation], _group] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,setWaypointFormation), [_x, _formation]] call CBA_fnc_serverEvent;
        } forEach SELECTED_WAYPOINTS;
    };
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
