#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens the Zeus attributes display for the given entity.
 *
 * Arguments:
 * 0: Entity <OBJECT|GROUP|ARRAY|STRING>
 * 1: Type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, "Object"] call zen_attributes_fnc_open
 *
 * Public: No
 */

params ["_entity", "_type"];

// Get active attributes for this type
private _attributes = GVAR(attributes) getVariable [_type, []];

_attributes = _attributes select {
    _entity call (_x select 6)
};

// Exit if the entity has no attributes to display
if (_attributes isEqualTo []) exitWith {};

createDialog QGVAR(display);
private _controls = [];

private _display = uiNamespace getVariable [QGVAR(display), displayNull];
_display setVariable [QGVAR(controls), _controls];
_display setVariable [QGVAR(entity), _entity];

private _ctrlContent = _display displayCtrl IDC_DISPLAY_CONTENT;
private _contentPosY = 0;

{
    _x params ["_displayName", "_tooltip", "_control", "_valueInfo", "_statement", "_defaultValue", "_condition"];

    private _ctrlAttribute = _display ctrlCreate [_control, IDC_ATTRIBUTE_GROUP, _ctrlContent];

    private _ctrlLabel = _ctrlAttribute controlsGroupCtrl IDC_ATTRIBUTE_LABEL;
    _ctrlLabel ctrlSetText _displayName;
    _ctrlLabel ctrlSetTooltip _tooltip;

    private _function = getText (configFile >> ctrlClassName _ctrlAttribute >> QGVAR(function));
    [_ctrlAttribute, _entity, _entity call _defaultValue, _valueInfo] call (missionNamespace getVariable _function);

    _ctrlAttribute ctrlSetPositionY _contentPosY;
    _ctrlAttribute ctrlCommit 0;

    _controls pushBack [_ctrlAttribute, _condition, _statement];
    _contentPosY = _contentPosY + (ctrlPosition _ctrlAttribute select 3) + VERTICAL_SPACING;
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
} forEach (GVAR(buttons) getVariable [_type, []]);

private _ctrlTitle = _display displayCtrl IDC_DISPLAY_TITLE;
_ctrlTitle ctrlSetPositionY (0.5 - _contentHeight / 2 - POS_H(1.6));
_ctrlTitle ctrlSetText (_entity call FUNC(getTitle));
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
