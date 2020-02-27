#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "icons" attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <ANY>
 * 2: Value Info <ARRAY>
 *   0: Icons <ARRAY>
 *     N: [Value <ANY>, Icon <STRING>, Tooltip <STRING>, X Position <NUMBER>, Y Position <NUMBER>, Size <NUMBER>, Color <ARRAY>, Condition <CODE>] <ARRAY>
 *   1: Height <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_controlsGroup, _defaultValue, _valueInfo] call zen_attributes_fnc_gui_icons
 *
 * Public: No
 */

#define ALPHA_NORMAL   0.5
#define ALPHA_SELECTED 1

#define SCALE_NORMAL   1
#define SCALE_SELECTED 1.2

params ["_controlsGroup", "_defaultValue", "_valueInfo"];
_valueInfo params [["_icons", [], [[]]], ["_height", 1, [0]]];

private _display = ctrlParent _controlsGroup;
private _controls = [];

{
    _x params [
        ["_value", _forEachIndex],
        ["_icon", "", [""]],
        ["_tooltip", "", [""]],
        ["_posX", 0, [0]],
        ["_posY", 0, [0]],
        ["_size", 0, [0]],
        ["_color", [1, 1, 1], [[]], [3, 4]],
        ["_condition", {true}, [{}]]
    ];

    if (_forEachIndex call _condition) then {
        if (isLocalized _tooltip) then {
            _tooltip = localize _tooltip;
        };

        _color set [3, ALPHA_SELECTED];

        private _ctrlIcon = _display ctrlCreate ["RscActivePicture", -1, _controlsGroup];
        _ctrlIcon ctrlSetPosition [POS_W(_posX), POS_H(_posY), POS_W(_size), POS_H(_size)];
        _ctrlIcon ctrlSetActiveColor _color;
        _ctrlIcon ctrlSetTooltip _tooltip;
        _ctrlIcon ctrlSetText _icon;
        _ctrlIcon ctrlCommit 0;

        if (_value isEqualTo _defaultValue) then {
            [_ctrlIcon, SCALE_SELECTED, 0] call BIS_fnc_ctrlSetScale;
        } else {
            _color set [3, ALPHA_NORMAL];
        };

        _ctrlIcon ctrlSetTextColor _color;

        _ctrlIcon setVariable [QGVAR(params), [_value, _controls]];
        _controls pushBack [_ctrlIcon, _color];

        _ctrlIcon ctrlAddEventHandler ["ButtonClick", {
            params ["_ctrlIcon"];
            (_ctrlIcon getVariable QGVAR(params)) params ["_value", "_controls"];

            private _controlsGroup = ctrlParentControlsGroup _ctrlIcon;
            _controlsGroup setVariable [QGVAR(value), _value];

            {
                _x params ["_ctrl", "_color"];

                private _scale = SCALE_NORMAL;

                if (_ctrl isEqualTo _ctrlIcon) then {
                    _color set [3, ALPHA_SELECTED];
                    _scale = SCALE_SELECTED;
                } else {
                    _color set [3, ALPHA_NORMAL];
                };

                _ctrl ctrlSetTextColor _color;
                [_ctrl, _scale, 0.1] call BIS_fnc_ctrlSetScale;
            } forEach _controls;
        }];
    };
} forEach _icons;

if (_height > 1) then {
    private _height = _height * (ctrlPosition _controlsGroup select 3);
    _controlsGroup ctrlSetPositionH _height;
    _controlsGroup ctrlCommit 0;

    private _ctrlLabel = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_LABEL;
    _ctrlLabel ctrlSetPositionH _height;
    _ctrlLabel ctrlCommit 0;

    private _ctrlBackground = _controlsGroup controlsGroupCtrl IDC_ATTRIBUTE_BACKGROUND;
    _ctrlBackground ctrlSetPositionH _height;
    _ctrlBackground ctrlCommit 0;
};
