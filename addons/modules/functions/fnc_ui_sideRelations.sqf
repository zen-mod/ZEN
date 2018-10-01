/*
 * Author: mharis001
 * Initializes the "Side Relations" Zeus module display.
 *
 * Arguments:
 * 0: sideRelations controls group <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_modules_fnc_ui_sideRelations
 *
 * Public: No
 */
#include "script_component.hpp"

#define SIDES [\
    ["STR_WEST", ICON_BLUFOR, 1],\
    ["STR_EAST", ICON_OPFOR, 0],\
    ["STR_guerrila", ICON_INDEPENDENT, 2]\
]

params ["_control"];

// Generic init
private _display = ctrlParent _control;
private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
TRACE_1("Logic Object",_logic);

_control ctrlRemoveAllEventHandlers "SetFocus";

private _ctrlToggle = _display displayCtrl IDC_SIDERELATIONS_TOGGLE;
_ctrlToggle ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlToggle"];

    // Set new value
    private _value = _ctrlToggle getVariable [QGVAR(value), 1];
    _ctrlToggle setVariable [QGVAR(value), 1 - _value];

    // Update icon and tooltip
    _ctrlToggle ctrlSetText ([ICON_FRIENDLY, ICON_HOSTILE] select _value);
    _ctrlToggle ctrlSetTooltip ([LLSTRING(FriendlyTo), LLSTRING(HostileTo)] select _value);
}];

private _ctrlSide1 = _display displayCtrl IDC_SIDERELATIONS_SIDE_1;
_ctrlSide1 ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlSide1", "_index"];

    private _display = ctrlParent _ctrlSide1;
    private _ctrlSide2 = _display displayCtrl IDC_SIDERELATIONS_SIDE_2;

    // Update second side combo, do not include selected side
    lbClear _ctrlSide2;
    {
        if (_index != _forEachIndex) then {
            _x params ["_name", "_icon", "_value"];

            private _index = _ctrlSide2 lbAdd localize _name;
            _ctrlSide2 lbSetPicture [_index, _icon];
            _ctrlSide2 lbSetValue [_index, _value];
        };
    } forEach SIDES;

    _ctrlSide2 lbSetCurSel 0;
}];

// Trigger EH to populate side combo 2
_ctrlSide1 lbSetCurSel 0;

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
    private _side1 = [_ctrlSide1 lbValue lbCurSel _ctrlSide1] call BIS_fnc_sideType;

    private _ctrlSide2 = _display displayCtrl IDC_SIDERELATIONS_SIDE_2;
    private _side2 = [_ctrlSide2 lbValue lbCurSel _ctrlSide2] call BIS_fnc_sideType;

    private _ctrlToggle = _display displayCtrl IDC_SIDERELATIONS_TOGGLE;
    private _friendValue = _ctrlToggle getVariable [QGVAR(value), 1];

    private _ctrlRadio = _display displayCtrl IDC_SIDERELATIONS_RADIO;
    private _radio = lbCurSel _ctrlRadio > 0;

    [_side1, _side2, _friendValue, _radio] call FUNC(moduleSideRelations);

    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
