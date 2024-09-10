#include "script_component.hpp"
/*
 * Author: mharis001, NeilZar
 * Initializes the "Ambient Flyby" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_modules_fnc_gui_ambientFlyby
 *
 * Public: No
 */

params ["_display", "_logic"];

private _selections = GVAR(saved) getVariable [QGVAR(ambientFlyby), [0, 0, 0, 0, 0, 250, 5000, 1, 0]];
_selections params ["_side", "_faction", "_aircraft", "_direction", "_useASL", "_height", "_distance", "_speed", "_amount"];

_display setVariable [QGVAR(position), getPosASL _logic];
deleteVehicle _logic;

private _fnc_sideChanged = {
    params ["_ctrlSide", "_index"];

    private _display = ctrlParent _ctrlSide;
    private _cfgFactionClasses = configFile >> "CfgFactionClasses";

    private _cache = uiNamespace getVariable QGVAR(aircraftCache);
    private _factions = keys (_cache select _index);

    private _ctrlFaction = _display displayCtrl IDC_AMBIENTFLYBY_FACTION;
    lbClear _ctrlFaction;

    {
        private _config = _cfgFactionClasses >> _x;
        private _name = getText (_config >> "displayName");
        private _icon = getText (_config >> "icon");

        private _index = _ctrlFaction lbAdd _name;
        _ctrlFaction lbSetPicture [_index, _icon];
        _ctrlFaction lbSetData [_index, _x];
    } forEach _factions;

    lbSort _ctrlFaction;
    _ctrlFaction lbSetCurSel 0;
};

private _ctrlSide = _display displayCtrl IDC_AMBIENTFLYBY_SIDE;
_ctrlSide ctrlAddEventHandler ["LBSelChanged", _fnc_sideChanged];
_ctrlSide lbSetCurSel _side;

private _fnc_factionChanged = {
    params ["_ctrlFaction", "_index"];

    private _display = ctrlParent _ctrlFaction;
    private _cfgVehicles = configFile >> "CfgVehicles";

    private _ctrlSide = _display displayCtrl IDC_AMBIENTFLYBY_SIDE;
    private _faction = _ctrlFaction lbData _index;

    private _cache = uiNamespace getVariable QGVAR(aircraftCache);
    private _aircraft = (_cache select lbCurSel _ctrlSide) get _faction;

    private _ctrlAircraft = _display displayCtrl IDC_AMBIENTFLYBY_AIRCRAFT;
    lbClear _ctrlAircraft;

    {
        private _name = getText (_cfgVehicles >> _x >> "displayName");
        private _icon = [_x] call EFUNC(common,getVehicleIcon);

        private _index = _ctrlAircraft lbAdd _name;
        _ctrlAircraft lbSetPicture [_index, _icon];
        _ctrlAircraft lbSetData [_index, _x];
    } forEach _aircraft;

    lbSort _ctrlAircraft;
    _ctrlAircraft lbSetCurSel 0;
};

private _ctrlFaction = _display displayCtrl IDC_AMBIENTFLYBY_FACTION;
_ctrlFaction ctrlAddEventHandler ["LBSelChanged", _fnc_factionChanged];
_ctrlFaction lbSetCurSel _faction;

private _ctrlAircraft = _display displayCtrl IDC_AMBIENTFLYBY_AIRCRAFT;
_ctrlAircraft lbSetCurSel _aircraft;

private _ctrlDirection = _display displayCtrl IDC_AMBIENTFLYBY_DIRECTION;
_ctrlDirection lbSetCurSel _direction;

private _ctrlHeightMode = _display displayCtrl IDC_AMBIENTFLYBY_HEIGHT_MODE;
_ctrlHeightMode lbSetCurSel _useASL;

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

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _position = _display getVariable QGVAR(position);

    private _ctrlSide = _display displayCtrl IDC_AMBIENTFLYBY_SIDE;
    private _side = lbCurSel _ctrlSide;

    private _ctrlFaction = _display displayCtrl IDC_AMBIENTFLYBY_FACTION;
    private _faction = lbCurSel _ctrlFaction;

    private _ctrlAircraft = _display displayCtrl IDC_AMBIENTFLYBY_AIRCRAFT;
    private _aircraft = lbCurSel _ctrlAircraft;

    private _ctrlDirection = _display displayCtrl IDC_AMBIENTFLYBY_DIRECTION;
    private _direction = lbCurSel _ctrlDirection;

    private _ctrlHeightMode = _display displayCtrl IDC_AMBIENTFLYBY_HEIGHT_MODE;
    private _useASL = lbCurSel _ctrlHeightMode;

    private _ctrlHeightSlider = _display displayCtrl IDC_AMBIENTFLYBY_HEIGHT_SLIDER;
    private _height = sliderPosition _ctrlHeightSlider;

    private _ctrlDistanceSlider = _display displayCtrl IDC_AMBIENTFLYBY_DISTANCE_SLIDER;
    private _distance = sliderPosition _ctrlDistanceSlider;

    private _ctrlSpeed = _display displayCtrl IDC_AMBIENTFLYBY_SPEED;
    private _speed = lbCurSel _ctrlSpeed;

    private _ctrlAmount = _display displayCtrl IDC_AMBIENTFLYBY_AMOUNT;
    private _amount = lbCurSel _ctrlAmount;

    private _selections = [_side, _faction, _aircraft, _direction, _useASL, _height, _distance, _speed, _amount];
    GVAR(saved) setVariable [QGVAR(ambientFlyby), _selections];

    private _aircraftType = _ctrlAircraft lbData _aircraft;

    [QGVAR(moduleAmbientFlyby), [_aircraftType, _position, _useASL == 1, _height, _distance, _direction, _speed, _amount + 1]] call CBA_fnc_serverEvent;
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
