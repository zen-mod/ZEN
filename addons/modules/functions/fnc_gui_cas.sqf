#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "CAS" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_modules_fnc_gui_cas
 *
 * Public: No
 */

params ["_display", "_logic"];

private _selections = GVAR(saved) getVariable [QGVAR(cas), [0, 0, 0, 0]];

private _casType = getNumber (configOf _logic >> QGVAR(casType));
_display setVariable [QGVAR(params), [_logic, _casType]];

private _cfgVehicles = configFile >> "CfgVehicles";
private _cfgFactionClasses = configFile >> "CfgFactionClasses";

private _ctrlList = _display displayCtrl IDC_CAS_LIST;

{
    _x params ["_planeClass"];

    private _planeConfig = _cfgVehicles >> _planeClass;
    private _planeName = getText (_planeConfig >> "displayName");
    private _planeIcon = getText (_planeConfig >> "picture");

    private _factionConfig = _cfgFactionClasses >> getText (_planeConfig >> "faction");
    private _factionName = getText (_factionConfig >> "displayName");
    private _factionIcon = getText (_factionConfig >> "icon");

    private _tooltip = format ["%1\n%2", _planeName, _factionName];

    private _index = _ctrlList lnbAddRow ["", "", _planeName];
    _ctrlList lbSetTooltip [_index * count lnbGetColumnsPosition _ctrlList, _tooltip];
    _ctrlList lnbSetPicture [[_index, 0], _factionIcon];
    _ctrlList lnbSetPicture [[_index, 1], _planeIcon];
    _ctrlList lnbSetValue [[_index, 0], _forEachIndex];
} forEach (uiNamespace getVariable QGVAR(casCache) select _casType);

_ctrlList lnbSort [2];
_ctrlList lnbSetCurSelRow (_selections select _casType);

private _fnc_onUnload = {
    params ["_display", "_exitCode"];
    (_display getVariable QGVAR(params)) params ["_logic"];

    if (_exitCode == IDC_CANCEL) then {
        deleteVehicle _logic;
    };
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    (_display getVariable QGVAR(params)) params ["_logic", "_casType"];

    private _casCache = uiNamespace getVariable QGVAR(casCache);
    private _ctrlList = _display displayCtrl IDC_CAS_LIST;
    private _selected = lnbCurSelRow _ctrlList;

    private _selections = GVAR(saved) getVariable [QGVAR(cas), [0, 0, 0, 0]];
    _selections set [_casType, _selected];
    GVAR(saved) setVariable [QGVAR(cas), _selections];

    private _planeID = _ctrlList lnbValue [_selected, 0];
    private _planeInfo = _casCache select _casType select _planeID;
    _planeInfo params ["_planeClass", "_planeWeapons"];

    _logic hideObject false;
    _logic setDir (missionNamespace getVariable [QGVAR(casDir), 0]);
    _logic setVariable [QEGVAR(attributes,disabled), true, true];

    [QGVAR(moduleCAS), [_logic, _casType, _planeClass, _planeWeapons]] call CBA_fnc_serverEvent;
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
