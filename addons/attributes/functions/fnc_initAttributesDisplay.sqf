/*
 * Author: mharis001
 * Initializes the Zeus attributes displays.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Display class name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, "RscAttributesMan"] call zen_attributes_fnc_initAttributesDisplay
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display", "_displayClass"];

private _displayConfig = configFile >> _displayClass;
private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

// Initialize and reposition attributes
private _ctrlContent = _display displayCtrl IDC_CONTENT;
private _contentPosY = 0;

{
    private _idc     = getNumber (_x >> "idc");
    private _control = _display displayCtrl _idc;

    private _function = getText (_x >> "function");
    _display call (missionNamespace getVariable _function);

    if (ctrlEnabled _control) then {
        private _controlPos = ctrlPosition _control;
        _controlPos set [1, _contentPosY];
        _control ctrlSetPosition _controlPos;

        _contentPosY = _contentPosY + (_controlPos select 3) + POS_H(0.1);
    } else {
        _control ctrlSetPosition [0, 0, 0, 0];
    };

    _control ctrlCommit 0;
} forEach configProperties [_displayConfig >> "controls" >> "Content" >> "controls", "isClass _x"];

private _contentHeight = (_contentPosY - POS_H(0.1)) min MAX_HEIGHT;

_ctrlContent ctrlSetPosition [
    POS_X(7),
    0.5 - _contentHeight / 2,
    POS_W(26),
    _contentHeight
];

_ctrlContent ctrlCommit 0;

// Reposition and set the title text
private _ctrlTitle = _display displayCtrl IDC_TITLE;

private _titleText = switch (true) do {
    case (_entity isEqualType objNull): {
        getText (configFile >> "CfgVehicles" >> typeOf _entity >> "displayName");
    };
    case (_entity isEqualType grpNull): {
        groupId _entity;
    };
    case (_entity isEqualType []): {
        _entity params ["_group", "_waypointID"];
        format ["%1: %2 #%3", _group, localize "str_a3_cfgmarkers_waypoint_0", _waypointID];
    };
    case (_entity isEqualType ""): {
        markerText _entity;
    };
};

_ctrlTitle ctrlSetPosition [
    POS_X(6.5),
    0.5 - _contentHeight / 2 - POS_H(1.6),
    POS_W(27),
    POS_H(1)
];

_ctrlTitle ctrlCommit 0;
_ctrlTitle ctrlSetText toUpper format [localize "str_a3_rscdisplayattributes_title", _titleText];

private _ctrlBackground = _display displayCtrl IDC_BACKGROUND;

_ctrlBackground ctrlSetPosition [
    POS_X(6.5),
    0.5 - _contentHeight / 2 - POS_H(0.5),
    POS_W(27),
    _contentHeight + POS_H(1)
];

_ctrlBackground ctrlCommit 0;

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlSetPosition [POS_X(28.5), 0.5 + _contentHeight / 2 + POS_H(0.6)];
_ctrlButtonOK ctrlCommit 0;

private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;
_ctrlButtonCancel ctrlSetPosition [POS_X(6.5), 0.5 + _contentHeight / 2 + POS_H(0.6)];
_ctrlButtonCancel ctrlCommit 0;

// Create custom buttons
{
    private _buttonText = getText (_x >> "text");
    private _function   = getText (_x >> "function");

    if (isNil _function) then {
        _function = compile _function;
    } else {
        _function = missionNamespace getVariable _function;
    };

    private _ctrlButton = _display ctrlCreate ["RscButtonMenu", -1];

    _ctrlButton ctrlSetPosition [
        POS_X(23.4) - POS_W(5.1) * (_forEachIndex mod 3),
        0.5 + _contentHeight / 2 + POS_H(0.6) + POS_H(1.1) * floor (_forEachIndex / 3),
        POS_W(5),
        POS_H(1)
    ];

    _ctrlButton ctrlCommit 0;
    _ctrlButton ctrlSetText _buttonText;
    _ctrlButton ctrlAddEventHandler ["ButtonClick", _function];
} forEach configProperties [_displayConfig >> "buttons", "isClass _x"];

// Add check to close the display when the entity is altered
private _fnc_closeDisplay = {
    params ["_display"];
    _display closeDisplay 2;
};

switch (true) do {
    case (_entity isEqualType objNull): {
        [{
            params ["_display", "_entity", "_wasAlive"];
            isNull _display || {_wasAlive && {!alive _entity}}
        }, _fnc_closeDisplay, [_display, _entity, alive _entity]] call CBA_fnc_waitUntilAndExecute;
    };
    case (_entity isEqualType grpNull): {
        [{
            params ["_display", "_entity"];
            isNull _display || {isNull _entity}
        }, _fnc_closeDisplay, [_display, _entity]] call CBA_fnc_waitUntilAndExecute;
    };
    case (_entity isEqualType []): {
        _entity params ["_group"];
        [{
            params ["_display", "_entity", "_wpCount"];
            isNull _display || {count waypoints _entity != _wpCount}
        }, _fnc_closeDisplay, [_display, _group, count waypoints _group]] call CBA_fnc_waitUntilAndExecute;
    };
    case (_entity isEqualType ""): {
        [{
            params ["_display", "_entity"];
            isNull _display || {markerType _entity == ""}
        }, _fnc_closeDisplay, [_display, _entity]] call CBA_fnc_waitUntilAndExecute;
    };
};
