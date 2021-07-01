#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates a dialog with the given rows of content.
 *
 * Arguments:
 * 0: Title <STRING>
 * 1: Content <ARRAY>
 * 2: On Confirm <CODE>
 * 3: On Cancel <CODE> (default: {})
 * 4: Arguments <ANY> (default: [])
 * 5: Save ID <STRING> (default: "")
 *
 * Return Value:
 * Dialog Created <BOOL>
 *
 * Example:
 * ["Example Dialog", [["CHECKBOX", "Yes?", false]], {systemChat format ["Result: %1", _this]}] call zen_dialog_fnc_create
 *
 * Public: Yes
 */

if (canSuspend) exitWith {
    [FUNC(create), _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith {};

params [
    ["_title", "", [""]],
    ["_content", [], [[]]],
    ["_onConfirm", {}, [{}]],
    ["_onCancel", {}, [{}]],
    ["_args", []],
    ["_saveID", "", [""]]
];

// Create a unique save ID from the parameters if one is not given
// Arguments are excluded since their string representations could change between calls
if (_saveID isEqualTo "") then {
    _saveID = [QGVAR(id), _title, _content, _onConfirm, _onCancel] joinString "$";
};

// Create the saved values namespace if needed
if (isNil QGVAR(saved)) then {
    GVAR(saved) = [] call CBA_fnc_createNamespace;
};

private _savedValues = GVAR(saved) getVariable [_saveID, []];

// Verify dialog content and exit if invalid parameters are given
// Split into separate step from control creation as invalid parameters would result in an incomplete dialog
scopeName "Main";

private _fnc_verifyListEntries = {
    params ["_values", "_labels", "_sort"];

    private _entries = [];

    {
        private _label = _labels param [_forEachIndex, str _x];
        _label params [["_text", "", [""]], ["_tooltip", "", [""]], ["_picture", "", [""]], ["_textColor", [1, 1, 1, 1], [[]], 4]];

        if (isLocalized _text) then {
            _text = localize _text;
        };

        if (isLocalized _tooltip) then {
            _tooltip = localize _tooltip;
        };

        _entries pushBack [_x, _text, _tooltip, _picture, _textColor];
    } forEach _values;

    if (_sort) then {
        [_entries, 1, true] call CBA_fnc_sortNestedArray;
    };

    _entries
};

{
    _x params [["_typeArg", "", [""]], ["_name", [], ["", []]], ["_valueInfo", []], ["_forceDefault", false, [true]]];
    _name params [["_label", "", [""]], ["_tooltip", "", [""]]];

    if (isLocalized _label) then {
        _label = localize _label;
    };

    if (isLocalized _tooltip) then {
        _tooltip = localize _tooltip;
    };

    // Get control type, settings, and default value from value info
    (toUpper _typeArg splitString ":") params [["_type", ""], ["_subType", ""]];

    private ["_defaultValue", "_controlType"];
    private _settings = [];

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
            _valueInfo params [["_values", [], [[]]], ["_labels", [], [[]]], ["_defaultIndex", 0, [0]], ["_sort", false, [false]]];

            if (_values isEqualTo []) then {
                {
                    _values pushBack _forEachIndex;
                } forEach _labels;
            };

            _defaultValue = _values param [_defaultIndex];
            _controlType = QGVAR(Row_Combo);

            private _entries = [_values, _labels, _sort] call _fnc_verifyListEntries;
            _settings append [_entries];
        };
        case "EDIT": {
            _valueInfo params [["_default", ""], ["_fnc_sanitizeValue", {_this}, [{}]], ["_height", 5, [0]]];

            if !(_default isEqualType "") then {
                _default = str _default;
            };

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

            private _isMulti = _subType in ["MULTI", "CODE"];
            _settings append [_fnc_sanitizeValue, _isMulti, _height];
        };
        case "LIST": {
            _valueInfo params [["_values", [], [[]]], ["_labels", [], [[]]], ["_defaultIndex", 0, [0]], ["_height", 6, [0]], ["_sort", false, [false]]];

            if (_values isEqualTo []) then {
                {
                    _values pushBack _forEachIndex;
                } forEach _labels;
            };

            _defaultValue = _values param [_defaultIndex];
            _controlType = QGVAR(Row_List);

            private _entries = [_values, _labels, _sort] call _fnc_verifyListEntries;
            _settings append [_entries, _height];
        };
        case "OWNERS": {
            _valueInfo params [["_sides", [], [[]], [0, 1, 2, 3, 4]], ["_groups", [], [[]]], ["_players", [], [[]]], ["_tab", 2, [0]]];

            _sides = _sides select {_x in [west, east, independent, civilian]};
            _groups = _groups select {units _x findIf {isPlayer _x} != -1};
            _players = _players call EFUNC(common,getPlayers);
            _tab = 0 max _tab min 2;

            _defaultValue = [_sides, _groups, _players, _tab];
            _controlType = QGVAR(Row_Owners);

            private _hideLabel = _subType == "NOTITLE";
            _settings append [_hideLabel];
        };
        case "SIDES": {
            _defaultValue = [_valueInfo] param [0, west, [west, []]];
            _controlType = QGVAR(Row_Sides);
        };
        case "SLIDER": {
            _valueInfo params [["_min", 0, [0]], ["_max", 1, [0]], ["_default", 0, [0]], ["_formatting", 2, [0, {}]], ["_radiusCenter", objNull, [objNull, []], 3], ["_radiusColor", [1, 1, 1, 0.7], [[]], 4]];

            _defaultValue = _default;
            _controlType = QGVAR(Row_Slider);

            private _isPercentage = _subType == "PERCENT";
            private _drawRadius = _subType == "RADIUS" && {_radiusCenter isNotEqualTo objNull};

            _settings append [_min, _max, _formatting, _isPercentage, _drawRadius, _radiusCenter, _radiusColor];
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

            // Adjust height based on number of rows when undefined
            if (_height == -1) then {
                _height = _rows;
            };

            _defaultValue = _default;
            _controlType = QGVAR(Row_Toolbox);

            private _isWide = _subType == "WIDE";
            _settings append [_returnBool, _rows, _columns, _strings, _height, _isWide];
        };
        case "VECTOR": {
            _defaultValue = [_valueInfo] param [0, [0, 0], [], [2, 3]];
            _controlType = [QGVAR(Row_VectorXY), QGVAR(Row_VectorXYZ)] select (count _defaultValue > 2);
        };
    };

    // Exit if default value could not be found
    // Could be wrong control type or invalid value info
    if (isNil "_defaultValue") then {
        WARNING_1("Wrong control type or invalid value info [%1] - could not find default value.",_typeArg);
        false breakOut "Main";
    };

    // Get saved value if default is not forced
    if (!_forceDefault) then {
        _defaultValue = _savedValues param [_forEachIndex, _defaultValue];
    };

    _content set [_forEachIndex, [_controlType, _label, _tooltip, _defaultValue, _settings]];
} forEach _content;

// Exit if dialog creation fails
if (!createDialog QEGVAR(common,RscDisplayScrollbars)) exitWith {false};

private _display = uiNamespace getVariable QEGVAR(common,display);

// Set the dialog's title
private _ctrlTitle = _display displayCtrl IDC_TITLE;

if (isLocalized _title) then {
    _title = localize _title;
};

_ctrlTitle ctrlSetText toUpper _title;

// Create and initialize the content controls
private _ctrlContent = _display displayCtrl IDC_CONTENT;
private _contentPosY = 0;
private _controls = [];

{
    _x params ["_controlType", "_label", "_tooltip", "_defaultValue", "_settings"];

    private _controlsGroup = _display ctrlCreate [_controlType, IDC_ROW_GROUP, _ctrlContent];

    // Set the control's label and tooltip
    private _ctrlLabel = _controlsGroup controlsGroupCtrl IDC_ROW_LABEL;
    _ctrlLabel ctrlSetText _label;
    _ctrlLabel ctrlSetTooltip _tooltip;

    // Execute control specific initialization function
    private _function = getText (configFile >> _controlType >> "function");
    [_controlsGroup, _defaultValue, _settings] call (missionNamespace getVariable _function);

    // Adjust the position of the control in the content group
    _controlsGroup ctrlSetPositionY _contentPosY;
    _controlsGroup ctrlCommit 0;

    _contentPosY = _contentPosY + (ctrlPosition _controlsGroup select 3) + VERTICAL_SPACING;

    _controls pushBack [_controlsGroup, _settings];
} forEach _content;

// Set the content control's height, subtract extra spacing added by the loop
_ctrlContent ctrlSetPositionH (_contentPosY - VERTICAL_SPACING);
_ctrlContent ctrlCommit 0;

// Adjust display element positions based on the content height
[_display, true] call EFUNC(common,initDisplayPositioning);

// Store the display's content controls, confirm/cancel functions, arguments, and save ID
_display setVariable [QGVAR(params), [_controls, _onConfirm, _onCancel, _args, _saveID]];

// Close dialog as confirmed when the ok button is clicked
private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    [_display, true] call FUNC(close);
}];

// Close dialog as cancelled when the cancel button is clicked
private _ctrlButtonCancel = _display displayCtrl IDC_CANCEL;
_ctrlButtonCancel ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonCancel"];

    private _display = ctrlParent _ctrlButtonCancel;
    [_display, false] call FUNC(close);
}];

// Close dialog as cancelled when the ESCAPE key is pressed
_display displayAddEventHandler ["KeyDown", {
    params ["_display", "_keyCode"];

    if (_keyCode == DIK_ESCAPE) then {
        [_display, false] call FUNC(close);
    };

    false
}];

true // Dialog successfully created
