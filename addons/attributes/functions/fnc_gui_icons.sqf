#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the `icons` attribute control type.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Entity <OBJECT|GROUP|ARRAY|STRING>
 * 2: Default Value <NUMBER>
 * 3: Value Info <ARRAY>
 *   0: Icons <ARRAY>
 *     N: [Icon <STRING>, Tooltip <STRING>, X Position <NUMBER>, Y Position <NUMBER>, Size <NUMBER>, Color <ARRAY>, Condition <CODE>] <ARRAY>
 *   1: Height <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_controlsGroup, _entity, 0, [[], 1]] call zen_attributes_fnc_gui_icons
 *
 * Public: No
 */

#define ALPHA_NORMAL   0.5
#define ALPHA_SELECTED 1

#define SCALE_NORMAL   1
#define SCALE_SELECTED 1.2

params ["_controlsGroup", "_entity", "_defaultValue", "_valueInfo"];
_valueInfo params [["_icons", [], [[]]], ["_height", 1, [0]]];

private _fnc_onButtonClick = {
    params ["_ctrlIcon"];
    (_ctrlIcon getVariable QGVAR(params)) params ["_controlsGroup", "_iconControls", "_selectedIndex"];

    {
        _x params ["_ctrlIcon", "_color"];

        private _scale = SCALE_NORMAL;

        if (_forEachIndex == _selectedIndex) then {
            _color set [3, ALPHA_SELECTED];
            _scale = SCALE_SELECTED;
        } else {
            _color set [3, ALPHA_NORMAL];
        };

        _ctrlIcon ctrlSetTextColor _color;
        [_ctrlIcon, _scale, 0.1] call BIS_fnc_ctrlSetScale;
    } forEach _iconControls;

    _controlsGroup setVariable [QGVAR(value), _selectedIndex];
};

private _display = ctrlParent _controlsGroup;
private _iconControls = [];

{
    _x params ["_icon", "_tooltip", "_posX", "_posY", "_size", ["_color", [1, 1, 1], [[]], [3, 4]], ["_condition", {true}, [{}]]];

    if (_forEachIndex call _condition) then {
        if (isLocalized _tooltip) then {
            _tooltip = localize _tooltip;
        };

        _color set [3, ALPHA_SELECTED];

        private _ctrlIcon = _display ctrlCreate ["RscActivePicture", -1, _controlsGroup];
        _ctrlIcon setVariable [QGVAR(params), [_controlsGroup, _iconControls, _forEachIndex]];

        _ctrlIcon ctrlSetText _icon;
        _ctrlIcon ctrlSetTooltip _tooltip;
        _ctrlIcon ctrlSetActiveColor _color;

        _ctrlIcon ctrlSetPosition [POS_W(_posX), POS_H(_posY), POS_W(_size), POS_H(_size)];
        _ctrlIcon ctrlCommit 0;

        if (_forEachIndex == _defaultValue) then {
            [_ctrlIcon, SCALE_SELECTED, 0] call BIS_fnc_ctrlSetScale;
        } else {
            _color set [3, ALPHA_NORMAL];
        };

        _ctrlIcon ctrlSetTextColor _color;
        _ctrlIcon ctrlAddEventHandler ["ButtonClick", _fnc_onButtonClick];

        _iconControls pushBack [_ctrlIcon, _color];
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
