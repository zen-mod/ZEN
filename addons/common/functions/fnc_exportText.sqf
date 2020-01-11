#include "script_component.hpp"
/*
 * Author: commy2, mharis001
 * Creates an export dialog with the given title and export text.
 * Allows users to copy text by clicking a button if possible.
 *
 * Arguments:
 * 0: Title <STRING>
 * 1: Text <STRING>
 * 2: Font <STRING> (default: "RobotoCondensed")
 * 3: Font Size <NUMBER> (default: 0.8)
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Export", "Info!"] call zen_common_fnc_exportText
 *
 * Public: No
 */

params [
    ["_title", "", [""]],
    ["_text", "", [""]],
    ["_font", "RobotoCondensed", [""]],
    ["_fontSize", 0.8, [1]]
];

if (!createDialog QGVAR(export)) exitWith {};

private _display = uiNamespace getVariable QGVAR(export);

if (isLocalized _title) then {
    _title = localize _title;
};

if (isLocalized _text) then {
    _text = localize _text;
};

private _ctrlTitle = _display displayCtrl IDC_EXPORT_TITLE;
_ctrlTitle ctrlSetText toUpper _title;

private _ctrlEdit = _display displayCtrl IDC_EXPORT_EDIT;
_ctrlEdit ctrlSetFontHeight _fontSize * POS_H(1);
_ctrlEdit ctrlSetFont _font;
_ctrlEdit ctrlSetText _text;

private _ctrlClose = _display displayCtrl IDC_EXPORT_CLOSE;
_ctrlClose ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlClose"];

    private _display = ctrlParent _ctrlClose;
    _display closeDisplay IDC_CANCEL;
}];

// Allow using button to copy text when copyToClipboard command is available
private _ctrlCopy = _display displayCtrl IDC_EXPORT_COPY;

if (isServer) then {
    _ctrlCopy ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrlCopy"];

        private _display = ctrlParent _ctrlCopy;
        private _ctrlEdit = _display displayCtrl IDC_EXPORT_EDIT;
        copyToClipboard ctrlText _ctrlEdit;
    }];
} else {
    _ctrlCopy ctrlShow false;
};

private _fnc_update = {
    params ["_display"];

    private _ctrlGroup = _display displayCtrl IDC_EXPORT_GROUP;
    private _ctrlEdit  = _display displayCtrl IDC_EXPORT_EDIT;

    private _height = (ctrlTextHeight _ctrlEdit + POS_H(4)) max (ctrlPosition _ctrlGroup select 3);
    _ctrlEdit ctrlSetPositionH _height;
    _ctrlEdit ctrlCommit 0;

    private _text = ctrlText _ctrlEdit;
    private _previousText = _ctrlEdit getVariable [QGVAR(previous), _text];
    _ctrlEdit setVariable [QGVAR(previous), _text];

    if (_text != _previousText && {_ctrlEdit ctrlSetText _text; _text find _previousText == 0}) then {
        _ctrlGroup ctrlSetAutoScrollSpeed 0.00001;
        _ctrlGroup ctrlSetAutoScrollDelay 0;
    } else {
        _ctrlGroup ctrlSetAutoScrollSpeed -1;
    };
};

_display displayAddEventHandler ["MouseMoving",  _fnc_update];
_display displayAddEventHandler ["MouseHolding", _fnc_update];
