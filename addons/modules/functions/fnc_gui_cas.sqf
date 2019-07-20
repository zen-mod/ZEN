#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "CAS" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_gui_cas
 *
 * Public: No
 */

params ["_display"];

if (isNil QGVAR(casLastSelected)) then {
    GVAR(casLastSelected) = [0, 0, 0, 0];
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

private _casType = getNumber (configFile >> "CfgVehicles" >> typeOf _logic >> QGVAR(casType));
private _casCache = uiNamespace getVariable QGVAR(casCache);

private _ctrlList = _display displayCtrl IDC_CAS_LIST;

private _cfgVehicles = configFile >> "CfgVehicles";
private _cfgFactionClasses = configFile >> "CfgFactionClasses";

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
} forEach (_casCache select _casType);

_ctrlList lnbSort [2];
_ctrlList lnbSetCurSelRow (GVAR(casLastSelected) select _casType);

private _fnc_onUnload = {
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    if (_this select 1 == IDC_CANCEL) then {
        deleteVehicle _logic;
    };
};

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    if (isNull _display) exitWith {};

    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    if (isNull _logic) exitWith {};

    _logic hideObject false;

    private _casType = getNumber (configFile >> "CfgVehicles" >> typeOf _logic >> QGVAR(casType));
    private _casCache = uiNamespace getVariable QGVAR(casCache);

    private _ctrlList = _display displayCtrl IDC_CAS_LIST;
    private _selected = lnbCurSelRow _ctrlList;
    GVAR(casLastSelected) set [_casType, _selected];

    private _planeID = _ctrlList lnbValue [_selected, 0];
    private _planeInfo = _casCache select _casType select _planeID;
    _planeInfo params ["_planeClass", "_planeWeapons"];

    _logic setDir (missionNamespace getVariable [QGVAR(casDir), 0]);
    _logic setVariable [QEGVAR(attributes,disabled), true, true];

    [QGVAR(moduleCAS), [_logic, _casType, _planeClass, _planeWeapons]] call CBA_fnc_serverEvent;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
