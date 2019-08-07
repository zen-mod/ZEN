#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Respawn Position" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeRespawnPosition
 *
 * Public: No
 */

#define IDCS [IDC_RESPAWNPOSITION_EAST, IDC_RESPAWNPOSITION_WEST, IDC_RESPAWNPOSITION_GUER, IDC_RESPAWNPOSITION_CIV, IDC_RESPAWNPOSITION_DISABLED]

params ["_display"];

private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

if (_entity isEqualType grpNull) then {
    _entity = leader _entity;
};

if !(alive _entity && {canMove _entity}) exitWith {
    {
        private _ctrl = _display displayCtrl _x;
        _ctrl ctrlEnable false;
        _ctrl ctrlShow false;
    } forEach IDCS;

    private _ctrlBackground = _display displayCtrl IDC_RESPAWNPOSITION_BACKGROUND;
    _ctrlBackground ctrlSetText localize "str_lib_info_na";
};

private _respawnIDs = _entity getVariable [QGVAR(respawnIDs), [[], [], [], [], []]];

private _iconColors = [
    [east] call BIS_fnc_sideColor,
    [west] call BIS_fnc_sideColor,
    [independent] call BIS_fnc_sideColor,
    [civilian] call BIS_fnc_sideColor,
    [1, 1, 1, 1]
];

private _fnc_onButtonClick = {
    params ["_activeCtrl"];

    private _display = ctrlParent _activeCtrl;
    private _activeIDC = ctrlIDC _activeCtrl;

    {
        private _ctrl = _display displayCtrl _x;
        private _color = _ctrl getVariable QGVAR(color);
        private _scale = 1;

        if (_activeIDC == _x) then {
            _color set [3, 1];
            _scale = 1.2
        } else {
            _color set [3, 0.5];
        };

        _ctrl ctrlSetTextColor _color;
        [_ctrl, _scale, 0.1] call BIS_fnc_ctrlSetScale;
    } forEach IDCS;

    private _respawnPos = IDCS find _activeIDC;
    _display setVariable [QGVAR(respawnPos), _respawnPos];
};

private _activeIndex = _respawnIDs findIf {!(_x isEqualTo [])};
if (_activeIndex == -1) then {_activeIndex = 4};

{
    private _ctrl = _display displayCtrl _x;
    private _side = [_forEachIndex] call BIS_fnc_sideType;

    if ([_side, _entity call BIS_fnc_objectSide] call BIS_fnc_areFriendly && {playableSlotsNumber _side > 0} || {_forEachIndex == 4}) then {
        private _color = _iconColors select _forEachIndex;
        _ctrl setVariable [QGVAR(color), _color];
        _ctrl ctrlSetActiveColor _color;
        _color set [3, 0.5];

        if (_activeIndex == _forEachIndex) then {
            [_ctrl, 1.2, 0] call BIS_fnc_ctrlSetScale;
            _color set [3, 1];
        };

        _ctrl ctrlSetTextColor _color;
        _ctrl ctrlAddEventHandler ["ButtonClick", _fnc_onButtonClick];
    } else {
        _ctrl ctrlEnable false;
        _ctrl ctrlShow false;
    };
} forEach IDCS;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _respawnPos = _display getVariable QGVAR(respawnPos);
    if (isNil "_respawnPos") exitWith {};

    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    private _respawnIDs = _entity getVariable [QGVAR(respawnIDs), [[], [], [], [], []]];

    {_x call BIS_fnc_removeRespawnPosition} forEach _respawnIDs;
    _respawnIDs = [[], [], [], [], []];

    if (_respawnPos == 4) then {
        _entity setVariable [QGVAR(respawnIDs), nil, true];
    } else {
        private _side = [_respawnPos] call BIS_fnc_sideType;
        _respawnIDs set [_respawnPos, [_side, _entity] call BIS_fnc_addRespawnPosition];
        _entity setVariable [QGVAR(respawnIDs), _respawnIDs, true];
    };
};

_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
