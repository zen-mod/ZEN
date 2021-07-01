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
 * [_object, "Object"] call zen_attributes_fnc_open
 *
 * Public: No
 */

params ["_entity", "_type"];

// Get the data for this display type, exit if the display has not been registered
private _data = GVAR(displays) getVariable _type;
if (isNil "_data") exitWith {};

_data params ["_title", "_check", "_attributes", "_buttons"];

// Filter active attributes, exit if none are active
_attributes = _attributes select {_entity call (_x select 6)};
if (_attributes isEqualTo []) exitWith {};

// Create the attributes display, exit if dialog creation fails
if (!createDialog QEGVAR(common,RscDisplayScrollbars)) exitWith {};

private _display = uiNamespace getVariable [QEGVAR(common,display), displayNull];
private _controls = [];

private _ctrlContent = _display displayCtrl IDC_CONTENT;
private _contentPosY = 0;

// Create the attributes for this attributes display
{
    _x params ["_displayName", "_tooltip", "_control", "_valueInfo", "_statement", "_defaultValue", "_condition"];

    private _controlsGroup = _display ctrlCreate [_control, IDC_ATTRIBUTE_GROUP, _ctrlContent];

    // Set the attribute label text and tooltip
    private _ctrlLabel = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_LABEL;
    _ctrlLabel ctrlSetText _displayName;
    _ctrlLabel ctrlSetTooltip _tooltip;

    // Get dynamic value info for the control if needed
    if (_valueInfo isEqualType {}) then {
        _valueInfo = _entity call _valueInfo;
    };

    // Execute attribute control specific init function
    private _function = getText (configFile >> _control >> "function");
    [_controlsGroup, _entity call _defaultValue, _valueInfo, _entity] call (missionNamespace getVariable _function);

    // Adjust the position of the attribute control in the content group
    _controlsGroup ctrlSetPositionY _contentPosY;
    _controlsGroup ctrlCommit 0;

    _contentPosY = _contentPosY + (ctrlPosition _controlsGroup select 3) + VERTICAL_SPACING;

    _controls pushBack [_controlsGroup, _condition, _statement];
} forEach _attributes;

// Set the content control's height, subtract extra spacing added by loop
_ctrlContent ctrlSetPositionH (_contentPosY - VERTICAL_SPACING);
_ctrlContent ctrlCommit 0;

// Adjust display element positions based on the content height
[_display, true] call EFUNC(common,initDisplayPositioning);

_display setVariable [QGVAR(controls), _controls];
_display setVariable [QGVAR(entity), _entity];

// Create the buttons for this attributes display
private _buttonPosY = 0.5 + (ctrlPosition _ctrlContent select 3) / 2 + POS_H(0.6);
private _index = 0;

{
    _x params ["_displayName", "_tooltip", "_statement", "_condition", "_closeDisplay"];

    if (_entity call _condition) then {
        private _ctrlButton = _display ctrlCreate ["RscButtonMenu", -1];
        _ctrlButton setVariable [QGVAR(params), [_statement, _condition, _closeDisplay]];

        _ctrlButton ctrlSetPosition [
            POS_X(23.4) - POS_W(5.1) * (_index mod 3),
            _buttonPosY + POS_H(1.1) * floor (_index / 3),
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
            private _entity = _display getVariable QGVAR(entity);

            if (_closeDisplay) then {
                _display closeDisplay IDC_CANCEL;
            };

            if (_entity call _condition) then {
                _entity call _statement;
            };
        }];

        _index = _index + 1;
    };
} forEach _buttons;

// Determine the entity specific description text
private _entityText = switch (true) do {
    case (_entity isEqualType objNull): {
        getText (configOf _entity >> "displayName");
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
private _ctrlTitle = _display displayCtrl IDC_TITLE;
_ctrlTitle ctrlSetText toUpper format [_title, _entityText];

// Handle confirming attribute changes
private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {call FUNC(confirm)}];

// Handle closing the display if the entity is no longer valid
if (_checkEntity) then {
    [_display, _entity] call FUNC(check);
};
