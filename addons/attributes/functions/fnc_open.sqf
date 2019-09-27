#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens the given attributes display type for the entity.
 *
 * Arguments:
 * 0: Entity <OBJECT|GROUP|ARRAY|STRING>
 * 1: Display Type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "Object"] call zen_attributes_fnc_open
 *
 * Public: No
 */

params ["_entity", "_displayType"];

// Get the data for this display type, exit if the display has not been registered
private _displayData = GVAR(displays) getVariable _displayType;
if (isNil "_displayData") exitWith {};

_displayData params ["_title", "_checkEntity", "_attributes", "_buttons"];

// Filter active attributes, exit if none are active
_attributes = _attributes select {_entity call (_x select 6)};
if (_attributes isEqualTo []) exitWith {};

// Create the attributes display, exit if dialog creation fails
if (!createDialog QGVAR(display)) exitWith {};

private _controls = [];

private _display = uiNamespace getVariable [QGVAR(display), displayNull];
_display setVariable [QGVAR(controls), _controls];
_display setVariable [QGVAR(entity), _entity];

private _ctrlContent = _display displayCtrl IDC_DISPLAY_CONTENT;
private _contentPosY = 0;

{
    _x params ["_displayName", "_tooltip", "_control", "_valueInfo", "_statement", "_defaultValue", "_condition"];

    private _ctrlAttribute = _display ctrlCreate [_control, IDC_ATTRIBUTE_GROUP, _ctrlContent];

    // Set the attribute label text and tooltip
    private _ctrlLabel = _ctrlAttribute controlsGroupCtrl IDC_ATTRIBUTE_LABEL;
    _ctrlLabel ctrlSetText _displayName;
    _ctrlLabel ctrlSetTooltip _tooltip;

    // Execute attribute control specific init function
    private _function = getText (configFile >> ctrlClassName _ctrlAttribute >> QGVAR(function));
    [_ctrlAttribute, _entity, _entity call _defaultValue, _valueInfo] call (missionNamespace getVariable _function);

    // Adjust the position of the attribute control in the content group
    _ctrlAttribute ctrlSetPositionY _contentPosY;
    _ctrlAttribute ctrlCommit 0;

    _contentPosY = _contentPosY + (ctrlPosition _ctrlAttribute select 3) + VERTICAL_SPACING;

    _controls pushBack [_ctrlAttribute, _condition, _statement];
} forEach _attributes;

private _contentHeight = _contentPosY - VERTICAL_SPACING;

if (_contentHeight > MAX_HEIGHT) then {
    _contentHeight = MAX_HEIGHT;

    // Increase width of the controls group to prevent overlap between scrollbar and controls
    ctrlPosition _ctrlContent params ["_posX", "", "_posW"];
    _ctrlContent ctrlSetPositionX (_posX - POS_W(0.25));
    _ctrlContent ctrlSetPositionW (_posW + POS_W(0.5));
    _ctrlContent ctrlCommit 0;
};

_ctrlContent ctrlSetPositionY (0.5 - _contentHeight / 2);
_ctrlContent ctrlSetPositionH _contentHeight;
_ctrlContent ctrlCommit 0;

// Create additional buttons for this attributes display
private _buttonIndex = 0;

{
    _x params ["_displayName", "_tooltip", "_statement", "_condition", "_closeDisplay"];

    if (_entity call _condition) then {
        private _ctrlButton = _display ctrlCreate ["RscButtonMenu", -1];
        _ctrlButton setVariable [QGVAR(params), [_statement, _condition, _closeDisplay]];

        _ctrlButton ctrlSetPosition [
            POS_X(23.4) - POS_W(5.1) * (_buttonIndex mod 3),
            0.5 + _contentHeight / 2 + POS_H(0.6) + POS_H(1.1) * floor (_buttonIndex / 3),
            POS_W(5),
            POS_H(1)
        ];

        _ctrlButton ctrlSetText _displayName;
        _ctrlButton ctrlSetTooltip _tooltip;
        _ctrlButton ctrlCommit 0;

        _ctrlButton ctrlAddEventHandler ["ButtonClick", {
            params ["_ctrlButton"];
            (_ctrlButton getVariable QGVAR(params)) params ["_statement", "_condition", "_closeDisplay"];

            private _display = ctrlParent _ctrlButton;
            private _entity  = _display getVariable QGVAR(entity);

            if (_closeDisplay) then {
                _display closeDisplay IDC_CANCEL;
            };

            if (_entity call _condition) then {
                _entity call _statement;
            };
        }];

        _buttonIndex = _buttonIndex + 1;
    };
} forEach _buttons;

// Determine the entity specific description text
private _entityText = switch (true) do {
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
        private _text = markerText _entity;

        if (_text == "") then {
            _text = localize "str_cfg_markers_marker";
        };

        _text
    };
};

// Use default title if the display was not registered with a specific one
if (_title == "") then {
    _title = localize "str_a3_rscdisplayattributes_title";
};

// Format the title with the entity specific text
_title = toUpper format [_title, _entityText];

// Reposition other controls based on the content height
private _ctrlTitle = _display displayCtrl IDC_DISPLAY_TITLE;
_ctrlTitle ctrlSetPositionY (0.5 - _contentHeight / 2 - POS_H(1.6));
_ctrlTitle ctrlSetText _title;
_ctrlTitle ctrlCommit 0;

private _ctrlBackground = _display displayCtrl IDC_DISPLAY_BACKGROUND;
_ctrlBackground ctrlSetPositionY (0.5 - _contentHeight / 2 - POS_H(0.5));
_ctrlBackground ctrlSetPositionH (_contentHeight + POS_H(1));
_ctrlBackground ctrlCommit 0;

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlSetPositionY (0.5 + _contentHeight / 2 + POS_H(0.6));
_ctrlButtonOK ctrlCommit 0;

private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;
_ctrlButtonCancel ctrlSetPositionY (0.5 + _contentHeight / 2 + POS_H(0.6));
_ctrlButtonCancel ctrlCommit 0;

// Handle closing the display if the entity is no longer valid
if (_checkEntity) then {
    private _fnc_closeDisplay = {
        params ["_display"];

        _display closeDisplay IDC_CANCEL;
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
                params ["_display", "_entity", "_waypointCount"];

                isNull _display || {count waypoints _entity != _waypointCount}
            }, _fnc_closeDisplay, [_display, _group, count waypoints _group]] call CBA_fnc_waitUntilAndExecute;
        };
        case (_entity isEqualType ""): {
            [{
                params ["_display", "_entity"];

                isNull _display || {markerType _entity == ""}
            }, _fnc_closeDisplay, [_display, _entity]] call CBA_fnc_waitUntilAndExecute;
        };
    };
};
