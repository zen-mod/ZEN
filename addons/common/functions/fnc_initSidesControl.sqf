#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the given side icons control.
 * If the default value is an array, multiple sides can be selected.
 * In this case, the array is modified by reference.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <SIDE|ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, west] call zen_common_fnc_initSidesControl
 *
 * Public: No
 */

#define ALPHA_NORMAL   0.5
#define ALPHA_SELECTED 1

#define SCALE_NORMAL   1
#define SCALE_SELECTED 1.2

params [["_controlsGroup", controlNull, [controlNull]], ["_defaultValue", west, [west, []]]];

// Allow multiple sides to be selected if default value is an array of sides
private _allowMultiple = _defaultValue isEqualType [];
_controlsGroup setVariable [QGVAR(value), _defaultValue];

private _fnc_updateIcon = {
    params ["_ctrl", "_color", "_selected"];

    private _scale = [SCALE_NORMAL, SCALE_SELECTED] select _selected;
    private _alpha = [ALPHA_NORMAL, ALPHA_SELECTED] select _selected;
    _color set [3, _alpha];

    _ctrl ctrlSetTextColor _color;
    [_ctrl, _scale, 0.1] call BIS_fnc_ctrlSetScale;
};

// Initialize icons with colors and handling to update value when clicked
private _controls = [];

{
    private _ctrlSide = _controlsGroup controlsGroupCtrl _x;
    private _color = [_forEachIndex] call BIS_fnc_sideColor;
    private _side  = [_forEachIndex] call BIS_fnc_sideType;

    _ctrlSide ctrlSetActiveColor _color;

    if (_side isEqualTo _defaultValue || {_allowMultiple && {_side in _defaultValue}}) then {
        [_ctrlSide, 1.2, 0] call BIS_fnc_ctrlSetScale;
    } else {
        _color set [3, 0.5];
    };

    _ctrlSide ctrlSetTextColor _color;

    if (_allowMultiple) then {
        [_ctrlSide, "ButtonClick", {
            params ["_ctrlSide"];
            _thisArgs params ["_color", "_side", "_fnc_updateIcon"];

            private _controlsGroup = ctrlParentControlsGroup _ctrlSide;
            private _value = _controlsGroup getVariable QGVAR(value);

            private _selected = _side in _value;

            if (_selected) then {
                _value deleteAt (_value find _side);
            } else {
                _value pushBack _side;
            };

            [_ctrlSide, _color, !_selected] call _fnc_updateIcon;
        }, [_color, _side, _fnc_updateIcon]] call CBA_fnc_addBISEventHandler;
    } else {
        [_ctrlSide, "ButtonClick", {
            params ["_ctrlSide"];
            _thisArgs params ["_controls", "_fnc_updateIcon"];

            private _controlsGroup = ctrlParentControlsGroup _ctrlSide;

            {
                _x params ["_ctrl", "_color", "_side"];

                private _selected = _ctrl isEqualTo _ctrlSide;
                [_ctrl, _color, _selected] call _fnc_updateIcon;

                if (_selected) then {
                    _controlsGroup setVariable [QGVAR(value), _side];
                };
            } forEach _controls;
        }, [_controls, _fnc_updateIcon]] call CBA_fnc_addBISEventHandler;

        _controls pushBack [_ctrlSide, _color, _side];
    };
} forEach [IDC_SIDES_OPFOR, IDC_SIDES_BLUFOR, IDC_SIDES_INDEPENDENT, IDC_SIDES_CIVILIAN];
