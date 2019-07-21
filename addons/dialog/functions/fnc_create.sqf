/*
 * Author: mharis001
 * Creates a dialog with given rows of content.
 *
 * Arguments:
 * 0: Title <STRING>
 * 1: Content <ARRAY>
 * 2: On Confirm <CODE>
 * 3: On Cancel <CODE> (default: {})
 * 4: Arguments <ANY> (default: [])
 *
 * Return Value:
 * Dialog Created <BOOL>
 *
 * Example:
 * ["Example Dialog", [["CHECKBOX", "Yes?", false]], {systemChat format ["Result: %1", _this]}] call zen_dialog_fnc_create
 *
 * Public: Yes
 */
#include "script_component.hpp"

if (canSuspend) exitWith {
    [FUNC(create), _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith {};

params [
    ["_title", "", [""]],
    ["_content", [], [[]]],
    ["_onConfirm", {}, [{}]],
    ["_onCancel", {}, [{}]],
    ["_arguments", []]
];

// Create saved values namespace
if (isNil QGVAR(saved)) then {
    GVAR(saved) = [] call CBA_fnc_createNamespace;
};

// Each unique set of params gets an id
// Arguments are excluded since their string representations could change between calls
private _saveId = [QGVAR(value), _title, _content, _onConfirm, _onCancel] joinString "$";
private _values = [];

// Verify content array and exit if invalid parameters given
// Split into separate step from control creation as invalid parameters would result in an incomplete dialog
scopeName "Main";

{
    _x params [["_typeArg", "", [""]], ["_name", [], ["", []]], ["_valueInfo", []], ["_forceDefault", false, [true]]];
    _name params [["_displayName", "", [""]], ["_tooltip", "", [""]]];

    // Localize row name and tooltip
    if (isLocalized _displayName) then {
        _displayName = localize _displayName;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    // Get control type, row settings, and default value from value info
    (toUpper _typeArg splitString ":") params [["_type", ""], ["_subType", ""]];

    private "_defaultValue";
    private _controlType = "";
    private _rowSettings = [];

    private _fnc_verifyListData = {
        if (_values isEqualTo []) then {
            {
                _values pushBack _forEachIndex;
            } forEach _labels;
        };

        _labels resize count _values;

        _labels = _labels apply {
            if (isNil "_x") then {
                _x = str (_values select _forEachIndex);
            };

            _x params [["_label", "", [""]], ["_tooltip", "", [""]], ["_picture", "", [""]], ["_textColor", [1, 1, 1, 1], [[]], 4]];

            if (isLocalized _label) then {
                _label = localize _label;
            };

            if (isLocalized _tooltip) then {
                _tooltip = localize _tooltip;
            };

            [_label, _tooltip, _picture, _textColor]
        };
    };

    switch (_type) do {
        case "CHECKBOX": {
            _defaultValue = _valueInfo param [0, false, [false]];
            _controlType = QGVAR(Row_Checkbox);
        };
        case "COLOR": {
            _defaultValue = [_valueInfo] param [0, [1, 1, 1], [[]], [3, 4]];
            _controlType = [QGVAR(Row_ColorRGB), QGVAR(Row_ColorRGBA)] select (count _defaultValue > 3);
        };
        case "COMBO": {
            _valueInfo params [["_values", [], [[]]], ["_labels", [], [[]]], ["_defaultIndex", 0, [0]]];

            [] call _fnc_verifyListData;
            _rowSettings append [_values, _labels];
            _defaultValue = _values param [_defaultIndex];
            _controlType = QGVAR(Row_Combo);
        };
        case "EDIT": {
            _valueInfo params [["_default", "", [""]], ["_fnc_sanitizeValue", {_this}, [{}]], ["_height", 5, [0]]];

            private _isMulti = _subType in ["MULTI", "CODE"];
            _rowSettings append [_fnc_sanitizeValue, _isMulti, _height];
            _defaultValue = _default;
            _controlType = switch (_subType) do {
                case "MULTI": {
                    QGVAR(Row_EditMulti);
                };
                case "CODE": {
                    QGVAR(Row_EditCode);
                };
                default {
                    QGVAR(Row_Edit);
                };
            };
        };
        case "LIST": {
            _valueInfo params [["_values", [], [[]]], ["_labels", [], [[]]], ["_defaultIndex", 0, [0]], ["_height", 6, [0]]];

            [] call _fnc_verifyListData;
            _rowSettings append [_values, _labels, _height];
            _defaultValue = _values param [_defaultIndex];
            _controlType = QGVAR(Row_List);
        };
        case "SIDES": {
            _defaultValue = _valueInfo param [0, nil, [west]];
            _controlType = QGVAR(Row_Sides);
        };
        case "SLIDER": {
            _valueInfo params [["_min", 0, [0]], ["_max", 1, [0]], ["_default", 0, [0]], ["_decimals", 2, [0]]];
            _rowSettings append [_min, _max, _decimals, _subType == "PERCENT"];
            _defaultValue = _default;
            _controlType = QGVAR(Row_Slider);
        };
        case "TOOLBOX": {
            // Backwards compatibility for old value info format
            if (_valueInfo param [1] isEqualType []) then {
                _valueInfo params ["_default", "_strings"];
                _valueInfo = [_default, 1, 2 max count _strings min 5, _strings];
            };

            _valueInfo params [["_default", 0, [0, false]], ["_rows", 1, [0]], ["_columns", 2, [0]], ["_strings", [], [[]]], ["_height", -1, [0]]];

            // Common toolbox use cases, for QOL mostly
            switch (_subType) do {
                case "YESNO": {
                    _strings = [ELSTRING(common,No), ELSTRING(common,Yes)];
                };
                case "ENABLED": {
                    _strings = [ELSTRING(common,Disabled), ELSTRING(common,Enabled)];
                };
            };

            _strings = _strings select [0, _rows * _columns] apply {if (isLocalized _x) then {localize _x} else {_x}};

            // Return bool if there are only two options and default is a bool
            private _returnBool = count _strings == 2 && {_default isEqualType false};

            // Ensure default is number if not returning bool
            if (!_returnBool && {_default isEqualType false}) then {
                _default = parseNumber _default;
            };

            // Adjust height based on number of rows when undefined
            if (_height == -1) then {
                _height = _rows;
            };

            _rowSettings append [_returnBool, _rows, _columns, _strings, _height, _subType == "WIDE"];
            _defaultValue = _default;
            _controlType = QGVAR(Row_Toolbox);
        };
        case "VECTOR": {
            _defaultValue = [_valueInfo] param [0, [0, 0], [], [2, 3]];
            _controlType = [QGVAR(Row_VectorXY), QGVAR(Row_VectorXYZ)] select (count _defaultValue > 2);
        };
    };

    // Exit if default value could not be found
    // Could be wrong control type or invalid value info
    if (isNil "_defaultValue") then {
        WARNING_1("Wrong control type [%1] - could not find default value",_type);
        false breakOut "Main";
    };

    // Get saved value if default is not forced
    if (!_forceDefault) then {
        private _valueId = [_saveId, _forEachIndex] joinString "$";
        _defaultValue = GVAR(saved) getVariable [_valueId, _defaultValue];
    };

    _values set [_forEachIndex, _defaultValue];
    _content set [_forEachIndex, [_controlType, _displayName, _tooltip, _defaultValue, _rowSettings]];
} forEach _content;

// Create the dialog and store current values array and params
if (!createDialog QGVAR(display)) exitWith {
    ERROR("Unable to create dialog");
    false
};

private _display = uiNamespace getVariable QGVAR(display);
_display setVariable [QGVAR(values), _values];
_display setVariable [QGVAR(params), [_onConfirm, _onCancel, _arguments, _saveId]];

// Set the dialog title
private _ctrlTitle = _display displayCtrl IDC_TITLE;

if (isLocalized _title) then {
    _title = localize _title;
};

_ctrlTitle ctrlSetText toUpper _title;

// Create and initialize the content controls
private _ctrlContent = _display displayCtrl IDC_CONTENT;
private _contentPosY = 0;

{
    _x params ["_controlType", "_displayName", "_tooltip", "_defaultValue", "_rowSettings"];

    private _ctrlRowGroup = _display ctrlCreate [_controlType, IDC_ROW_GROUP, _ctrlContent];

    // Set the row name and tooltip
    private _ctrlRowName = _ctrlRowGroup controlsGroupCtrl IDC_ROW_NAME;
    _ctrlRowName ctrlSetText _displayName;
    _ctrlRowName ctrlSetTooltip _tooltip;

    // Execute control specific init script
    private _script = getText (configFile >> ctrlClassName _ctrlRowGroup >> QGVAR(script));
    [_ctrlRowGroup, _forEachIndex, _defaultValue, _rowSettings] call (missionNamespace getVariable _script);

    // Adjust the y position of the row
    private _position = ctrlPosition _ctrlRowGroup;
    _position set [1, _contentPosY];

    _ctrlRowGroup ctrlSetPosition _position;
    _ctrlRowGroup ctrlCommit 0;

    _contentPosY = _contentPosY + (_position select 3) + VERTICAL_SPACING;
} forEach _content;

// Update content position
private _contentHeight = MIN_HEIGHT max (_contentPosY - VERTICAL_SPACING) min MAX_HEIGHT;
_ctrlContent ctrlSetPosition [POS_X(7), POS_CONTENT_Y(_contentHeight), POS_W(26), _contentHeight];
_ctrlContent ctrlCommit 0;

// Update title and background position
private _ctrlBackground = _display displayCtrl IDC_BACKGROUND;
_ctrlBackground ctrlSetPosition [POS_X(6.5), POS_BACKGROUND_Y(_contentHeight), POS_W(27), POS_BACKGROUND_H(_contentHeight)];
_ctrlBackground ctrlCommit 0;

_ctrlTitle ctrlSetPosition [POS_X(6.5), POS_TITLE_Y(_contentHeight)];
_ctrlTitle ctrlCommit 0;

// Update button positions and add EHs
private _ctrlButtonOK = _display displayCtrl IDC_BTN_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", FUNC(gui_confirm)];
_ctrlButtonOK ctrlSetPosition [POS_X(28.5), POS_BUTTON_Y(_contentHeight)];
_ctrlButtonOK ctrlCommit 0;

private _ctrlButtonCancel = _display displayCtrl IDC_BTN_CANCEL;
_ctrlButtonCancel ctrlAddEventHandler ["ButtonClick", FUNC(gui_cancel)];
_ctrlButtonCancel ctrlSetPosition [POS_X(6.5), POS_BUTTON_Y(_contentHeight)];
_ctrlButtonCancel ctrlCommit 0;

// Add EH to trigger cancel when escape key pressed
_display displayAddEventHandler ["KeyDown", {
    params ["_display", "_key"];

    if (_key == DIK_ESCAPE) then {
        private _values = _display getVariable QGVAR(values);
        (_display getVariable QGVAR(params)) params ["", "_onCancel", "_arguments"];

        [_values, _arguments] call _onCancel;
    };

    false
}];

true
