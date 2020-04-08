#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Side Relations" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_modules_fnc_gui_sideRelations
 *
 * Public: No
 */

params ["_display", "_logic"];

private _selections = GVAR(saved) getVariable [QGVAR(sideRelations), [0, 0, true, 0]];
_selections params ["_side1", "_side2", "_friendly", "_radio"];

deleteVehicle _logic;

private _ctrlSide1 = _display displayCtrl IDC_SIDERELATIONS_SIDE_1;
private _ctrlSide2 = _display displayCtrl IDC_SIDERELATIONS_SIDE_2;

_ctrlSide1 ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlSide1", "_selectedIndex"];

    private _display = ctrlParent _ctrlSide1;
    private _ctrlSide2 = _display displayCtrl IDC_SIDERELATIONS_SIDE_2;
    private _currentValue = _ctrlSide2 lbValue lbCurSel _ctrlSide2;

    // Update side 2 combo, do not include selected side
    lbClear _ctrlSide2;

    for "_i" from 0 to (lbSize _ctrlSide1 - 1) do {
        if (_i != _selectedIndex) then {
            private _name  = _ctrlSide1 lbText _i;
            private _icon  = _ctrlSide1 lbPicture _i;
            private _value = _ctrlSide1 lbValue _i;

            private _index = _ctrlSide2 lbAdd _name;
            _ctrlSide2 lbSetPicture [_index, _icon];
            _ctrlSide2 lbSetValue [_index, _value];

            if (_value == _currentValue) then {
                _ctrlSide2 lbSetCurSel _index;
            };
        };
    };
}];

_ctrlSide1 lbSetCurSel _side1;
_ctrlSide2 lbSetCurSel _side2;

private _fnc_relationToggled = {
    params ["_ctrlToggle"];

    private _friendly = _ctrlToggle getVariable [QGVAR(friendly), true];
    _ctrlToggle setVariable [QGVAR(friendly), !_friendly];

    if (_friendly) then {
        _ctrlToggle ctrlSetText ICON_HOSTILE;
        _ctrlToggle ctrlSetTooltip localize LSTRING(HostileTo);
    } else {
        _ctrlToggle ctrlSetText ICON_FRIENDLY;
        _ctrlToggle ctrlSetTooltip localize LSTRING(FriendlyTo);
    };
};

private _ctrlToggle = _display displayCtrl IDC_SIDERELATIONS_TOGGLE;
_ctrlToggle ctrlAddEventHandler ["ButtonClick", _fnc_relationToggled];

if (!_friendly) then {
    _ctrlToggle call _fnc_relationToggled;
};

private _ctrlRadio = _display displayCtrl IDC_SIDERELATIONS_RADIO;
_ctrlRadio lbSetCurSel _radio;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;

    private _ctrlSide1 = _display displayCtrl IDC_SIDERELATIONS_SIDE_1;
    private _side1 = lbCurSel _ctrlSide1;

    private _ctrlSide2 = _display displayCtrl IDC_SIDERELATIONS_SIDE_2;
    private _side2 = lbCurSel _ctrlSide2;

    private _ctrlToggle = _display displayCtrl IDC_SIDERELATIONS_TOGGLE;
    private _friendly = _ctrlToggle getVariable [QGVAR(friendly), true];

    private _ctrlRadio = _display displayCtrl IDC_SIDERELATIONS_RADIO;
    private _radio = lbCurSel _ctrlRadio;

    private _selections = [_side1, _side2, _friendly, _radio];
    GVAR(saved) setVariable [QGVAR(sideRelations), _selections];

    _side1 = [_ctrlSide1 lbValue _side1] call BIS_fnc_sideType;
    _side2 = [_ctrlSide2 lbValue _side2] call BIS_fnc_sideType;

    [_side1, _side2, _friendly, _radio > 0] call FUNC(moduleSideRelations);
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
