/*
 * Author: mharis001
 * Initializes the "Editable Objects" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_gui_editableObjects
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display"];

private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

(_display displayCtrl IDC_EDITABLEOBJECTS_MODE)     lbSetCurSel 1;
(_display displayCtrl IDC_EDITABLEOBJECTS_CURATORS) lbSetCurSel 1;

private _ctrlRangeMode = _display displayCtrl IDC_EDITABLEOBJECTS_RANGE_MODE;
_ctrlRangeMode ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlRangeMode", "_index"];

    private _display = ctrlParent _ctrlRangeMode;
    private _enable = _index == 0;

    {
        (_display displayCtrl _x) ctrlEnable _enable;
    } forEach [
        IDC_EDITABLEOBJECTS_RANGE_SLIDER,
        IDC_EDITABLEOBJECTS_RANGE_EDIT
    ];
}];

private _ctrlRangeSlider = _display displayCtrl IDC_EDITABLEOBJECTS_RANGE_SLIDER;
private _ctrlRangeEdit   = _display displayCtrl IDC_EDITABLEOBJECTS_RANGE_EDIT;
[_ctrlRangeSlider, _ctrlRangeEdit, 10, 10000, 100, 50] call EFUNC(common,initSliderEdit);

private _fnc_checkedAll = {
    params ["_ctrlFilterAll", "_checked"];

    private _display = ctrlParent _ctrlFilterAll;
    private _enable = _checked == 0;

    {
        (_display displayCtrl _x) ctrlEnable _enable;
    } forEach [
        IDC_EDITABLEOBJECTS_FILTER_UNITS,
        IDC_EDITABLEOBJECTS_FILTER_VEHICLES,
        IDC_EDITABLEOBJECTS_FILTER_STATIC
    ];
};

private _ctrlFilterAll = _display displayCtrl IDC_EDITABLEOBJECTS_FILTER_ALL;
_ctrlFilterAll ctrlAddEventHandler ["CheckedChanged", _fnc_checkedAll];
[_ctrlFilterAll, 1] call _fnc_checkedAll;

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

    private _position = ASLtoAGL getPosASL _logic;

    private _editingMode = lbCurSel (_display displayCtrl IDC_EDITABLEOBJECTS_MODE) > 0;
    private _curator = [getAssignedCuratorLogic player, objNull] select lbCurSel (_display displayCtrl IDC_EDITABLEOBJECTS_CURATORS);

    private _range = if (lbCurSel (_display displayCtrl IDC_EDITABLEOBJECTS_RANGE_MODE) == 0) then {
        sliderPosition (_display displayCtrl IDC_EDITABLEOBJECTS_RANGE_SLIDER)
    } else {
        -1 // -1 to indicate entire mission
    };

    private _filter = [
        cbChecked (_display displayCtrl IDC_EDITABLEOBJECTS_FILTER_ALL),
        cbChecked (_display displayCtrl IDC_EDITABLEOBJECTS_FILTER_UNITS),
        cbChecked (_display displayCtrl IDC_EDITABLEOBJECTS_FILTER_VEHICLES),
        cbChecked (_display displayCtrl IDC_EDITABLEOBJECTS_FILTER_STATIC)
    ];

    [QGVAR(moduleEditableObjects), [_position, _editingMode, _curator, _range, _filter]] call CBA_fnc_serverEvent;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
