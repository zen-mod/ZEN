#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Ambient Flyby" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_gui_ambientFlyby
 *
 * Public: No
 */

params ["_display"];

if (isNil QGVAR(lastAmbientFlyby)) then {
    GVAR(lastAmbientFlyby) = [0, 0, 0, 0, 250, 3000, 1, 0];
};

GVAR(lastAmbientFlyby) params ["_side", "_faction", "_aircraft", "_direction", "_height", "_distance", "_speed", "_amount"];

private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

private _ctrlSide     = _display displayCtrl IDC_AMBIENTFLYBY_SIDE;
private _ctrlFaction  = _display displayCtrl IDC_AMBIENTFLYBY_FACTION;
private _ctrlAircraft = _display displayCtrl IDC_AMBIENTFLYBY_AIRCRAFT;

private _fnc_sideChanged = {
    params ["_ctrlSide", "_sideIndex"];

    private _display = ctrlParent _ctrlSide;
    private _ctrlFaction = _display displayCtrl IDC_AMBIENTFLYBY_FACTION;

    private _aircraftCache = uiNamespace getVariable QGVAR(aircraftCache);
    private _sideArray     = _aircraftCache select _sideIndex;

    private _cfgFactionClasses = configFile >> "CfgFactionClasses";
    lbClear _ctrlFaction;

    {
        _x params ["_faction"];

        private _config = _cfgFactionClasses >> _faction;
        private _displayName = getText (_config >> "displayName");
        private _icon = getText (_config >> "icon");

        private _index = _ctrlFaction lbAdd _displayName;
        _ctrlFaction lbSetPicture [_index, _icon];
        _ctrlFaction lbSetData [_index, _faction];
    } forEach _sideArray;

    lbSort _ctrlFaction;
    _ctrlFaction lbSetCurSel 0;
};

private _fnc_factionChanged = {
    params ["_ctrlFaction", "_factionIndex"];

    private _faction = _ctrlFaction lbData _factionIndex;

    private _display = ctrlParent _ctrlFaction;
    private _ctrlSide     = _display displayCtrl IDC_AMBIENTFLYBY_SIDE;
    private _ctrlAircraft = _display displayCtrl IDC_AMBIENTFLYBY_AIRCRAFT;

    private _aircraftCache = uiNamespace getVariable QGVAR(aircraftCache);
    private _sideArray     = _aircraftCache select lbCurSel _ctrlSide;
    private _aircraftArray = _sideArray select (_sideArray findIf {_x select 0 == _faction}) select 1;

    private _cfgVehicles = configFile >> "CfgVehicles";
    lbClear _ctrlAircraft;

    {
        private _config = _cfgVehicles >> _x;
        private _displayName = getText (_config >> "displayName");
        private _icon = getText (_config >> "icon");

        private _index = _ctrlAircraft lbAdd _displayName;
        _ctrlAircraft lbSetPicture [_index, _icon];
        _ctrlAircraft lbSetData [_index, _x];
    } forEach _aircraftArray;

    lbSort _ctrlAircraft;
    _ctrlAircraft lbSetCurSel 0;
};

_ctrlSide    ctrlAddEventHandler ["LBSelChanged", _fnc_sideChanged];
_ctrlFaction ctrlAddEventHandler ["LBSelChanged", _fnc_factionChanged];

_ctrlSide     lbSetCurSel _side;
_ctrlFaction  lbSetCurSel _faction;
_ctrlAircraft lbSetCurSel _aircraft;

private _ctrlDirection = _display displayCtrl IDC_AMBIENTFLYBY_DIRECTION;
_ctrlDirection lbSetCurSel _direction;

private _ctrlHeightSlider = _display displayCtrl IDC_AMBIENTFLYBY_HEIGHT_SLIDER;
private _ctrlHeightEdit   = _display displayCtrl IDC_AMBIENTFLYBY_HEIGHT_EDIT;
[_ctrlHeightSlider, _ctrlHeightEdit, 10, 5000, _height, 50] call EFUNC(common,initSliderEdit);

private _ctrlDistanceSlider = _display displayCtrl IDC_AMBIENTFLYBY_DISTANCE_SLIDER;
private _ctrlDistanceEdit   = _display displayCtrl IDC_AMBIENTFLYBY_DISTANCE_EDIT;
[_ctrlDistanceSlider, _ctrlDistanceEdit, 1000, 10000, _distance, 100] call EFUNC(common,initSliderEdit);

private _ctrlSpeed = _display displayCtrl IDC_AMBIENTFLYBY_SPEED;
_ctrlSpeed lbSetCurSel _speed;

private _ctrlAmount = _display displayCtrl IDC_AMBIENTFLYBY_AMOUNT;
_ctrlAmount lbSetCurSel _amount;

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

    private _ctrlSide = _display displayCtrl IDC_AMBIENTFLYBY_SIDE;
    private _side = lbCurSel _ctrlSide;

    private _ctrlFaction = _display displayCtrl IDC_AMBIENTFLYBY_FACTION;
    private _faction = lbCurSel _ctrlFaction;

    private _ctrlAircraft = _display displayCtrl IDC_AMBIENTFLYBY_AIRCRAFT;
    private _aircraft = lbCurSel _ctrlAircraft;
    private _aircraftType = _ctrlAircraft lbData _aircraft;

    private _ctrlDirection = _display displayCtrl IDC_AMBIENTFLYBY_DIRECTION;
    private _direction = lbCurSel _ctrlDirection;

    private _ctrlHeightSlider = _display displayCtrl IDC_AMBIENTFLYBY_HEIGHT_SLIDER;
    private _height = sliderPosition _ctrlHeightSlider;

    private _ctrlDistanceSlider = _display displayCtrl IDC_AMBIENTFLYBY_DISTANCE_SLIDER;
    private _distance = sliderPosition _ctrlDistanceSlider;

    private _ctrlSpeed = _display displayCtrl IDC_AMBIENTFLYBY_SPEED;
    private _speed = lbCurSel _ctrlSpeed;

    private _ctrlAmount = _display displayCtrl IDC_AMBIENTFLYBY_AMOUNT;
    private _amount = lbCurSel _ctrlAmount;

    GVAR(lastAmbientFlyby) = [_side, _faction, _aircraft, _direction, _height, _distance, _speed, _amount];

    [
        QGVAR(moduleAmbientFlyby),
        [_aircraftType, ASLtoAGL getPosASL _logic, _height, _distance, _direction, _speed, _amount + 1]
    ] call CBA_fnc_serverEvent;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
