#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens a message box dialog with the given title and message text.
 * When an empty picture path is provided, the message width is increased.
 *
 * Arguments:
 * 0: Title <STRING>
 * 1: Message <STRING>
 * 2: Confirm <CODE>
 * 3: Cancel <CODE> (default: {})
 * 4: Arguments <ANY> (default: [])
 * 5: Picture <STRING> (default: "\a3\3den\data\displays\display3denmsgbox\picture_ca.paa")
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Confirm", "Are you sure?", {hint "Confirmed!"}] call zen_common_fnc_messageBox
 *
 * Public: No
 */

if (canSuspend) exitWith {
    [FUNC(messageBox), _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith {};

params [
    ["_title", "", [""]],
    ["_message", "", [""]],
    ["_fnc_confirm", {}, [{}]],
    ["_fnc_cancel", {}, [{}]],
    ["_args", []],
    ["_picture", "\a3\3den\data\displays\display3denmsgbox\picture_ca.paa", [""]]
];

if (!createDialog QGVAR(messageBox)) exitWith {};

private _display = uiNamespace getVariable QGVAR(messageBox);

if (isLocalized _title) then {
    _title = localize _title;
};

if (isLocalized _message) then {
    _message = localize _message;
};

private _ctrlTitle = _display displayCtrl IDC_MESSAGE_TITLE;
_ctrlTitle ctrlSetText toUpper _title;

private _ctrlText = _display displayCtrl IDC_MESSAGE_TEXT;
_ctrlText ctrlSetStructuredText parseText _message;

// Handle hiding picture and increasing message width
private _ctrlPicture = _display displayCtrl IDC_MESSAGE_PICTURE;

if (_picture == "") then {
    _ctrlPicture ctrlShow false;
    _ctrlText ctrlSetPositionX POS_X(13);
    _ctrlText ctrlSetPositionW POS_W(14);
    _ctrlText ctrlCommit 0;
} else {
    _ctrlPicture ctrlSetText _picture;
    _ctrlPicture ctrlSetPositionY (0.5 - POS_H(1));
    _ctrlPicture ctrlCommit 0;
};

// Align message text to the center of the box
private _height = ctrlTextHeight _ctrlText;

_ctrlText ctrlSetPositionY (0.5 - _height / 2);
_ctrlText ctrlSetPositionH _height;
_ctrlText ctrlCommit 0;

// Reposition other controls based on text height
_height = _height / 2 max POS_H(1.25);

_ctrlTitle ctrlSetPositionY (0.5 - _height - POS_H(1.6));
_ctrlTitle ctrlCommit 0;

private _ctrlBackground = _display displayCtrl IDC_MESSAGE_BACKGROUND;
_ctrlBackground ctrlSetPositionY (0.5 - _height - POS_H(0.5));
_ctrlBackground ctrlSetPositionH (2 * _height + POS_H(1));
_ctrlBackground ctrlCommit 0;

private _buttonY = 0.5 + _height + POS_H(0.6);

// Add events to buttons to trigger their associated functions
private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;
_ctrlButtonCancel ctrlSetPositionY _buttonY;
_ctrlButtonCancel ctrlCommit 0;

[_ctrlButtonCancel, "ButtonClick", {
    _thisArgs params ["_args", "_fnc_cancel"];
    _args call _fnc_cancel;
}, [_args, _fnc_cancel]] call CBA_fnc_addBISEventHandler;

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlSetPositionY _buttonY;
_ctrlButtonOK ctrlCommit 0;

[_ctrlButtonOK, "ButtonClick", {
    _thisArgs params ["_args", "_fnc_confirm"];
    _args call _fnc_confirm;
}, [_args, _fnc_confirm]] call CBA_fnc_addBISEventHandler;
