/*
 * Author: mharis001
 * Initializes the SIDES content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Row Index <NUMBER>
 * 2: Current Value <SIDE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, west] call zen_dialog_fnc_gui_sides
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_controlsGroup", "_rowIndex", "_currentValue"];

{
    private _ctrlSide = _controlsGroup controlsGroupCtrl _x;
    private _color = [_forEachIndex] call BIS_fnc_sideColor;
    private _side  = [_forEachIndex] call BIS_fnc_sideType;

    _ctrlSide setVariable [QGVAR(params), [_rowIndex, _side, _color]];
    _ctrlSide ctrlAddEventHandler ["ButtonClick", {
        params ["_ctrlSide"];
        (_ctrlSide getVariable QGVAR(params)) params ["_rowIndex", "_selectedSide"];

        private _controlsGroup = ctrlParentControlsGroup _ctrlSide;

        {
            private _ctrlSide = _controlsGroup controlsGroupCtrl _x;
            (_ctrlSide getVariable QGVAR(params)) params ["", "_side", "_color"];

            private _scale = 1;

            if (_side == _selectedSide) then {
                _color set [3, 1];
                _scale = 1.2;
            } else {
                _color set [3, 0.5];
            };

            _ctrlSide ctrlSetTextColor _color;
            [_ctrlSide, _scale, 0.1] call BIS_fnc_ctrlSetScale;
        } forEach IDCS_ROW_SIDES;

        private _display = ctrlParent _ctrlSide;
        private _values = _display getVariable QGVAR(values);
        _values set [_rowIndex, _selectedSide];
    }];

    _ctrlSide ctrlSetActiveColor _color;

    if (_side == _currentValue) then {
        [_ctrlSide, 1.2, 0] call BIS_fnc_ctrlSetScale;
    } else {
        _color set [3, 0.5];
    };

    _ctrlSide ctrlSetTextColor _color;
} forEach IDCS_ROW_SIDES;
