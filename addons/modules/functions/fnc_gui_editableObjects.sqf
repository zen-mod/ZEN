#include "script_component.hpp"
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

params ["_display"];

if (isNil QGVAR(lastEditableObjects)) then {
    GVAR(lastEditableObjects) = [1, 1, 0, 100, [true, true, true, true]];
};

GVAR(lastEditableObjects) params ["_editingMode", "_curators", "_rangeMode", "_range", "_filter"];

private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _ctrlEditingMode = _display displayCtrl IDC_EDITABLEOBJECTS_MODE;
_ctrlEditingMode lbSetCurSel _editingMode;

private _ctrlCurators = _display displayCtrl IDC_EDITABLEOBJECTS_CURATORS;
_ctrlCurators lbSetCurSel _curators;

private _fnc_rangeModeChanged = {
    params ["_ctrlRangeMode", "_index"];

    private _display = ctrlParent _ctrlRangeMode;
    private _enabled = _index == 0;

    {
        (_display displayCtrl _x) ctrlEnable _enabled;
    } forEach [
        IDC_EDITABLEOBJECTS_RANGE_SLIDER,
        IDC_EDITABLEOBJECTS_RANGE_EDIT
    ];
};

private _ctrlRangeMode = _display displayCtrl IDC_EDITABLEOBJECTS_RANGE_MODE;
_ctrlRangeMode ctrlAddEventHandler ["ToolBoxSelChanged", _fnc_rangeModeChanged];
_ctrlRangeMode lbSetCurSel _rangeMode;

[_ctrlRangeMode, _rangeMode] call _fnc_rangeModeChanged;

private _ctrlRangeSlider = _display displayCtrl IDC_EDITABLEOBJECTS_RANGE_SLIDER;
private _ctrlRangeEdit   = _display displayCtrl IDC_EDITABLEOBJECTS_RANGE_EDIT;
[_ctrlRangeSlider, _ctrlRangeEdit, 10, 10000, _range, 50] call EFUNC(common,initSliderEdit);

_filter params ["_filterAll", "_filterUnits", "_filterVehicles", "_filterStatic"];

private _fnc_filterAllChanged = {
    params ["_ctrlFilterAll", "_checked"];

    private _display = ctrlParent _ctrlFilterAll;
    private _enabled = _checked == 0;

    {
        (_display displayCtrl _x) ctrlEnable _enabled;
    } forEach [
        IDC_EDITABLEOBJECTS_FILTER_UNITS,
        IDC_EDITABLEOBJECTS_FILTER_VEHICLES,
        IDC_EDITABLEOBJECTS_FILTER_STATIC
    ];
};

private _ctrlFilterAll = _display displayCtrl IDC_EDITABLEOBJECTS_FILTER_ALL;
_ctrlFilterAll ctrlAddEventHandler ["CheckedChanged", _fnc_filterAllChanged];
_ctrlFilterAll cbSetChecked _filterAll;

[_ctrlFilterAll, parseNumber _filterAll] call _fnc_filterAllChanged;

private _ctrlFilterUnits = _display displayCtrl IDC_EDITABLEOBJECTS_FILTER_UNITS;
_ctrlFilterUnits cbSetChecked _filterUnits;

private _ctrlFilterVehicles = _display displayCtrl IDC_EDITABLEOBJECTS_FILTER_VEHICLES;
_ctrlFilterVehicles cbSetChecked _filterVehicles;

private _ctrlFilterStatic = _display displayCtrl IDC_EDITABLEOBJECTS_FILTER_STATIC;
_ctrlFilterStatic cbSetChecked _filterStatic;

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

    private _ctrlEditingMode = _display displayCtrl IDC_EDITABLEOBJECTS_MODE;
    private _editingMode = lbCurSel _ctrlEditingMode;

    private _ctrlCurators = _display displayCtrl IDC_EDITABLEOBJECTS_CURATORS;
    private _curators = lbCurSel _ctrlCurators;

    private _ctrlRangeMode = _display displayCtrl IDC_EDITABLEOBJECTS_RANGE_MODE;
    private _rangeMode = lbCurSel _ctrlRangeMode;

    private _ctrlRange = _display displayCtrl IDC_EDITABLEOBJECTS_RANGE_SLIDER;
    private _range = sliderPosition _ctrlRange;

    private _filter = [
        cbChecked (_display displayCtrl IDC_EDITABLEOBJECTS_FILTER_ALL),
        cbChecked (_display displayCtrl IDC_EDITABLEOBJECTS_FILTER_UNITS),
        cbChecked (_display displayCtrl IDC_EDITABLEOBJECTS_FILTER_VEHICLES),
        cbChecked (_display displayCtrl IDC_EDITABLEOBJECTS_FILTER_STATIC)
    ];

    GVAR(lastEditableObjects) = [_editingMode, _curators, _rangeMode, _range, _filter];

    // Use objNull to indicate all curators
    private _curator = [getAssignedCuratorLogic player, objNull] select _curators;

    // Use range -1 to indicate entire mission
    if (_rangeMode == 1) then {
        _range = -1;
    };

    [QGVAR(moduleEditableObjects), [ASLtoAGL getPosASL _logic, _editingMode > 0, _curator, _range, _filter]] call CBA_fnc_serverEvent;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
