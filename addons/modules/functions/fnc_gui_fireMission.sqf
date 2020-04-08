#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Fire Mission" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_modules_fnc_gui_fireMission
 *
 * Public: No
 */

#define LOGIC_TYPE_TARGET QGVAR(moduleCreateTarget)

params ["_display", "_logic"];

private _selections = GVAR(saved) getVariable [QGVAR(fireMission), [1, "", -3, 0, 99, "", 1]];
_selections params ["_mode", "_grid", "_target", "_spread", "_units", "_ammo", "_rounds"];

private _vehicle = attachedTo _logic;
private _position = ASLToAGL getPosASL _logic;
deleteVehicle _logic;

// Exit if the module was not placed on an object
if (isNull _vehicle) exitWith {
    _display closeDisplay IDC_CANCEL;
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

// Exit if the object is not an artillery vehicle
private _vehicleType = typeOf _vehicle;
private _isVLS = _vehicle call EFUNC(common,isVLS);

if (getNumber (configFile >> "CfgVehicles" >> _vehicleType >> "artilleryScanner") == 0 && {!_isVLS}) exitWith {
    _display closeDisplay IDC_CANCEL;
    [LSTRING(ModuleFireMission_NotArtillery)] call EFUNC(common,showMessage);
};

// Exit if no nearby vehicles of the same type have a gunner
private _vehicles = _vehicle nearObjects [_vehicleType, 100] select {!isNull gunner _x};

if (_vehicles isEqualTo []) exitWith {
    _display closeDisplay IDC_CANCEL;
    [LSTRING(ModuleFireMission_NoGunners)] call EFUNC(common,showMessage);
};

_display setVariable [QGVAR(params), [_position, _vehicles]];

private _ctrlGrid = _display displayCtrl IDC_FIREMISSION_TARGET_GRID;
_ctrlGrid ctrlSetText _grid;

private _ctrlMode = _display displayCtrl IDC_FIREMISSION_MODE;
private _ctrlTarget = _display displayCtrl IDC_FIREMISSION_TARGET_LOGIC;

// Limit to map grid only if a target logic doesn't exist
if (LOGIC_TYPE_TARGET call EFUNC(position_logics,exists)) then {
    private _fnc_modeChanged = {
        params ["_ctrlMode", "_index"];

        private _display = ctrlParent _ctrlMode;
        private _label = ["str_3den_display3den_menubar_grid_text", ELSTRING(common,Target)] select _index;

        private _ctrlGrid = _display displayCtrl IDC_FIREMISSION_TARGET_GRID;
        _ctrlGrid ctrlShow (_index == 0);

        private _ctrlTarget = _display displayCtrl IDC_FIREMISSION_TARGET_LOGIC;
        _ctrlTarget ctrlShow (_index == 1);

        private _ctrlLabel = _display displayCtrl IDC_FIREMISSION_TARGET_LABEL;
        _ctrlLabel ctrlSetText localize _label;
    };

    _ctrlMode ctrlAddEventHandler ["ToolBoxSelChanged", _fnc_modeChanged];
    _ctrlMode lbSetCurSel _mode;

    [_ctrlMode, _mode] call _fnc_modeChanged;

    [_ctrlTarget, LOGIC_TYPE_TARGET, _target, false, _position] call EFUNC(position_logics,initList);
} else {
    _ctrlTarget ctrlShow false;
    _ctrlMode ctrlSetTooltip localize LSTRING(NoTargetModules);
    _ctrlMode ctrlSetFade 0.5;
    _ctrlMode ctrlEnable false;
    _ctrlMode ctrlCommit 0;
};

private _ctrlSpreadSlider = _display displayCtrl IDC_FIREMISSION_SPREAD_SLIDER;
private _ctrlSpreadEdit   = _display displayCtrl IDC_FIREMISSION_SPREAD_EDIT;
[_ctrlSpreadSlider, _ctrlSpreadEdit, 0, 1000, _spread, 10] call EFUNC(common,initSliderEdit);

private _ctrlUnits = _display displayCtrl IDC_FIREMISSION_UNITS;

for "_i" from 1 to count _vehicles do {
    _ctrlUnits lbAdd str _i;
};

_ctrlUnits lbSetCurSel (lbSize _ctrlUnits min _units) - 1;

private _cfgMagazines = configFile >> "CfgMagazines";
private _ctrlAmmo = _display displayCtrl IDC_FIREMISSION_AMMO;
private _artilleryAmmo = if (_isVLS) then {magazines _vehicle} else {getArtilleryAmmo _vehicles};

{
    _ctrlAmmo lbSetData [_ctrlAmmo lbAdd (getText (_cfgMagazines >> _x >> "displayName")), _x];
} forEach _artilleryAmmo;

_ctrlAmmo lbSetCurSel ((_artilleryAmmo find _ammo) max 0);

private _ctrlRounds = _display displayCtrl IDC_FIREMISSION_ROUNDS;
_ctrlRounds ctrlSetText str _rounds;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    (_display getVariable QGVAR(params)) params ["_position", "_vehicles"];

    private _ctrlMode = _display displayCtrl IDC_FIREMISSION_MODE;
    private _mode = lbCurSel _ctrlMode;

    private _ctrlGrid = _display displayCtrl IDC_FIREMISSION_TARGET_GRID;
    private _grid = ctrlText _ctrlGrid;

    private _ctrlTarget = _display displayCtrl IDC_FIREMISSION_TARGET_LOGIC;
    private _target = _ctrlTarget lbValue lbCurSel _ctrlTarget;

    private _ctrlSpreadSlider = _display displayCtrl IDC_FIREMISSION_SPREAD_SLIDER;
    private _spread = sliderPosition _ctrlSpreadSlider;

    private _ctrlUnits = _display displayCtrl IDC_FIREMISSION_UNITS;
    private _units = lbCurSel _ctrlUnits + 1;

    private _ctrlAmmo = _display displayCtrl IDC_FIREMISSION_AMMO;
    private _ammo = _ctrlAmmo lbData lbCurSel _ctrlAmmo;

    private _ctrlRounds = _display displayCtrl IDC_FIREMISSION_ROUNDS;
    private _rounds = parseNumber ctrlText _ctrlRounds;

    private _selections = [_mode, _grid, _target, _spread, _units, _ammo, _rounds];
    GVAR(saved) setVariable [QGVAR(fireMission), _selections];

    _vehicles = _vehicles select {alive _x && {!isNull gunner _x} && {_ammo in getArtilleryAmmo [_x] || {_ammo in magazines _x}}};
    _vehicles resize (_units min count _vehicles);

    _target = [LOGIC_TYPE_TARGET, _target, _position] call EFUNC(position_logics,select);

    [FUNC(moduleFireMission), [_vehicles, [_grid, _target] select _mode, _spread, _ammo, _rounds]] call CBA_fnc_execNextFrame;
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
