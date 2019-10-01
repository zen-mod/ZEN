#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Side Relations" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_gui_sideRelations
 *
 * Public: No
 */

params ["_display"];

if (isNil QGVAR(lastSideRelations)) then {
    GVAR(lastSideRelations) = [0, 0, 1, 0];
};

GVAR(lastSideRelations) params ["_side1", "_side2", "_friendValue", "_radio"];

private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _ctrlSide1 = _display displayCtrl IDC_SIDERELATIONS_SIDE_1;
_ctrlSide1 ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlSide1", "_selectedIndex"];

    private _display = ctrlParent _ctrlSide1;
    private _ctrlSide2 = _display displayCtrl IDC_SIDERELATIONS_SIDE_2;
    private _currentValue = _ctrlSide2 lbValue lbCurSel _ctrlSide2;

    // Update side 2 combo, do not include selected side
    lbClear _ctrlSide2;

    for "_i" from 0 to (lbSize _ctrlSide1 - 1) do {
        if (_i != _selectedIndex) then {
            private _value = _ctrlSide1 lbValue _i;

            private _index = _ctrlSide2 lbAdd (_ctrlSide1 lbText _i);
            _ctrlSide2 lbSetPicture [_index, _ctrlSide1 lbPicture _i];
            _ctrlSide2 lbSetValue [_index, _value];

            if (_value == _currentValue) then {
                _ctrlSide2 lbSetCurSel _index;
            };
        };
    };
}];

// Trigger EH to populate side 2 combo
_ctrlSide1 lbSetCurSel _side1;
_ctrlSide2 lbSetCurSel _side2;

private _fnc_relationToggled = {
    params ["_ctrlToggle"];

    // Flip the friend value
    private _value = _ctrlToggle getVariable [QGVAR(value), 1];
    _ctrlToggle setVariable [QGVAR(value), 1 - _value];

    // Update icon and tooltip
    if (_value > 0) then {
        _ctrlToggle ctrlSetText ICON_FRIENDLY;
        _ctrlToggle ctrlSetTooltip localize LSTRING(FriendlyTo);
    } else {
        _ctrlToggle ctrlSetText ICON_HOSTILE;
        _ctrlToggle ctrlSetTooltip localize LSTRING(HostileTo);
    };
};

private _ctrlToggle = _display displayCtrl IDC_SIDERELATIONS_TOGGLE;
_ctrlToggle ctrlAddEventHandler ["ButtonClick", _fnc_relationToggled];

if (_friendValue != 1) then {
    _ctrlToggle call _fnc_relationToggled;
};

private _ctrlRadio = _display displayCtrl IDC_SIDERELATIONS_RADIO;
_ctrlRadio lbSetCurSel _radio;

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    deleteVehicle _logic;
};

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    private _ctrlSide1 = _display displayCtrl IDC_SIDERELATIONS_SIDE_1;
    private _side1 = lbCurSel _ctrlSide1;

    private _ctrlSide2 = _display displayCtrl IDC_SIDERELATIONS_SIDE_2;
    private _side2 = lbCurSel _ctrlSide2;

    private _ctrlToggle = _display displayCtrl IDC_SIDERELATIONS_TOGGLE;
    private _friendValue = _ctrlToggle getVariable [QGVAR(value), 1];

    private _ctrlRadio = _display displayCtrl IDC_SIDERELATIONS_RADIO;
    private _radio = lbCurSel _ctrlRadio;

    GVAR(lastSideRelations) = [_side1, _side2, _friendValue, _radio];

    _side1 = [_ctrlSide1 lbValue _side1] call BIS_fnc_sideType;
    _side2 = [_ctrlSide2 lbValue _side2] call BIS_fnc_sideType;

    [_side1, _side2, _friendValue, _radio > 0] call FUNC(moduleSideRelations);
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
