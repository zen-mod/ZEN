/*
 * Author: Bohemia Interactive, mharis001
 * Initializes the Zeus attributes displays.
 * Called from onLoad EH.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Display class name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, "RscAttributesMan"] call zen_attributes_fnc_initAttributesDisplay
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_display", "_displayClass"];

private _ctrlTitle = _display displayCtrl IDC_ATTRIBUTES_TITLE;
private _ctrlBackground = _display displayCtrl IDC_ATTRIBUTES_BACKGROUND;
private _ctrlContent = _display displayCtrl IDC_ATTRIBUTES_CONTENT;

private _ctrlTitlePos = ctrlPosition _ctrlTitle;
private _ctrlBackgroundPos = ctrlPosition _ctrlBackground;
private _ctrlContentPos = ctrlPosition _ctrlContent;

// Calculate vertical spacing offsets
private _ctrlTitleOffset = (_ctrlBackgroundPos select 1) - (_ctrlTitlePos select 1) - (_ctrlTitlePos select 3);
private _ctrlContentOffset = (_ctrlContentPos select 1) - (_ctrlBackgroundPos select 1);

// Show fake map in the background if Zeus Display map is open
private _ctrlMap = _display displayCtrl IDC_ATTRIBUTES_MAP;
_ctrlMap ctrlEnable false;

if (visibleMap) then {
    private _ctrlMapCurator = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
    _ctrlMap ctrlMapAnimAdd [0, ctrlMapScale _ctrlMapCurator, _ctrlMapCurator ctrlMapScreenToWorld [0.5, 0.5]];
    ctrlMapAnimCommit _ctrlMap;
} else {
    _ctrlMap ctrlShow false;
};

// Set the title text based on target
private _target = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

private _titleText = switch (true) do {
    case (_target isEqualType objNull): {
        getText (configFile >> "CfgVehicles" >> typeOf _target >> "displayName");
    };
    case (_target isEqualType grpNull): {
        groupId _target;
    };
    case (_target isEqualType []): {
        _target params ["_group", "_waypointID"];
        format ["%1: %2 #%3", _group, localize "str_a3_cfgmarkers_waypoint_0", _waypointID];
    };
    case (_target isEqualType ""): {
        markerText _target;
    };
};

_ctrlTitle ctrlSetText toUpper format [localize "str_a3_rscdisplayattributes_title", _titleText];

// Determine which attributes should be shown
private _displayConfig = configFile >> _displayClass;

private _attributes = if (getNumber (_displayConfig >> "filterAttributes") > 0) then {GETMVAR(BIS_fnc_initCuratorAttributes_attributes,[])} else {["%ALL"]};
private _allAttributes = "%ALL" in _attributes;

// Check if adminOnly attributes (code execution) should be enabled
private _enableAdmin = isServer || {serverCommandAvailable "#shutdown" || BIS_fnc_isDebugConsoleAllowed};

// Initialize and reposition attributes
private _posY = _ctrlContentOffset;

{
    private _configName = configName _x;
    private _idc = getNumber (_x >> "idc");
    private _ctrl = _display displayCtrl _idc;

    if ((_allAttributes || {_attributes findIf {_x == _configName} > -1}) && {_enableAdmin || {getNumber (_x >> "adminOnly") == 0}}) then {
        private _ctrlPos = ctrlPosition _ctrl;
        _ctrlPos set [1, _posY];
        _ctrl ctrlSetPosition _ctrlPos;
        _posY = _posY + (_ctrlPos select 3) + POS_H(0.1);
        ctrlSetFocus _ctrl;
    } else {
        _ctrl ctrlSetPosition [0, 0, 0, 0];
        _ctrl ctrlShow false;
    };

    _ctrl ctrlCommit 0;
} forEach ("true" configClasses (_displayConfig >> "controls" >> "Content" >> "controls"));

// Reposition other controls based on content height
private _posH = ((_posY + _ctrlContentOffset - POS_H(0.1)) min 0.8 * safeZoneH) / 2;

_ctrlTitlePos set [1, 0.5 - _posH - (_ctrlTitlePos select 3) - _ctrlTitleOffset];
_ctrlTitle ctrlSetPosition _ctrlTitlePos;
_ctrlTitle ctrlCommit 0;

_ctrlBackgroundPos set [1, 0.5 - _posH];
_ctrlBackgroundPos set [3, _posH * 2];
_ctrlBackground ctrlSetPosition _ctrlBackgroundPos;
_ctrlBackground ctrlCommit 0;

_ctrlContentPos set [1, 0.5 - _posH];
_ctrlContentPos set [3, _posH * 2];
_ctrlContent ctrlSetPosition _ctrlContentPos;
_ctrlContent ctrlCommit 0;

{
    private _ctrl = _display displayCtrl _x;
    private _ctrlPos = ctrlPosition _ctrl;
    _ctrlPos set [1, 0.5 + _posH + _ctrlTitleOffset];
    _ctrl ctrlSetPosition _ctrlPos;
    _ctrl ctrlCommit 0;
} forEach [IDC_OK, IDC_CANCEL, IDC_ATTRIBUTES_CUSTOM_1, IDC_ATTRIBUTES_CUSTOM_2, IDC_ATTRIBUTES_CUSTOM_3];

// Add check to close the display when the entity is altered
private _fnc_closeDisplay = {
    params ["_display"];
    _display closeDisplay 2;
};

switch (true) do {
    case (_target isEqualType objNull): {
        [{
            params ["_display", "_target", "_wasAlive"];
            isNull _display || {_wasAlive && {!alive _target}}
        }, _fnc_closeDisplay, [_display, _target, alive _target]] call CBA_fnc_waitUntilAndExecute;
    };
    case (_target isEqualType grpNull): {
        [{
            params ["_display", "_target"];
            isNull _display || {isNull _target}
        }, _fnc_closeDisplay, [_display, _target]] call CBA_fnc_waitUntilAndExecute;
    };
    case (_target isEqualType []): {
        _target params ["_group"];
        [{
            params ["_display", "_target", "_wpCount"];
            isNull _display || {count waypoints _target != _wpCount}
        }, _fnc_closeDisplay, [_display, _group, count waypoints _group]] call CBA_fnc_waitUntilAndExecute;
    };
    case (_target isEqualType ""): {
        [{
            params ["_display", "_target"];
            isNull _display || {markerType _target == ""}
        }, _fnc_closeDisplay, [_display, _target]] call CBA_fnc_waitUntilAndExecute;
    };
};
