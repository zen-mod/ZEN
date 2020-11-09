#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates current vehicle information display.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_garage_fnc_showVehicleInfo
 *
 * Public: No
 */

private _display = findDisplay IDD_DISPLAY;
private _vehicleConfig = configOf GVAR(center);

private _ctrlInfoName = _display displayCtrl IDC_INFO_NAME;
private _displayName = getText (_vehicleConfig >> "displayName");
_ctrlInfoName ctrlSetText _displayName;

private _ctrlInfoAuthor = _display displayCtrl IDC_INFO_AUTHOR;
private _authorName = getText (_vehicleConfig >> "author");
_authorName = if (_authorName == "") then {localize "STR_Author_Unknown"} else {format [localize "STR_Format_Author_Scripted", _authorName]};
_ctrlInfoAuthor ctrlSetText _authorName;

private _ctrlDLC = _display displayCtrl IDC_DLC_ICON;
private _ctrlDLCBackground = _display displayCtrl IDC_DLC_BACKGROUND;
private _vehicleDLC = _vehicleConfig call EFUNC(common,getDLC);

if (_vehicleDLC != "") then {
    private _dlcParams = modParams [_vehicleDLC, ["name", "logo", "logoOver"]];
    _dlcParams params ["_name", "_logo", "_logoOver"];

    _ctrlDLC ctrlSetText _logo;
    _ctrlDLC ctrlSetTooltip _name;

    _ctrlDLC ctrlAddEventHandler ["MouseExit", format ["(_this select 0) ctrlSetText '%1'", _logo]];
    _ctrlDLC ctrlAddEventHandler ["MouseEnter", format ["(_this select 0) ctrlSetText '%1'", _logoOver]];
} else {
    _ctrlDLC ctrlSetFade 1;
    _ctrlDLC ctrlCommit 0;

    _ctrlDLCBackground ctrlSetFade 1;
    _ctrlDLCBackground ctrlCommit 0;
};
