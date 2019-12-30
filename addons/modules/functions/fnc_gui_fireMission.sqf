#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Fire Mission" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_gui_fireMission
 *
 * Public: No
 */

params ["_display"];

if (isNil QGVAR(lastFireMission)) then {
    GVAR(lastFireMission) = [1, "", -3, 0, 99, "", 1];
};

GVAR(lastFireMission) params ["_mode", "_grid", "_target", "_spread", "_units", "_ammo", "_rounds"];

private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
private _ctrlButtonOK = _display displayCtrl IDC_OK;

scopeName "Main";
private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call EFUNC(common,showMessage);
    breakOut "Main";
};

// Module was placed on a unit
private _vehicle = attachedTo _logic;

if (isNull _vehicle) then {
    [LSTRING(NoUnitSelected)] call _fnc_errorAndClose;
};

// Attached unit is an artillery vehicle
private _vehicleType = typeOf _vehicle;

if (getNumber (configFile >> "CfgVehicles" >> _vehicleType >> "artilleryScanner") == 0 && !(_vehicle call EFUNC(common,isVLS))) then {
    [LSTRING(ModuleFireMission_NotArtillery)] call _fnc_errorAndClose;
};

// At least one artillery vehicle has a gunner
private _vehicles = _vehicle nearObjects [_vehicleType, 100] select {!isNull gunner _x};

if (_vehicles isEqualTo []) then {
    [LSTRING(ModuleFireMission_NoGunners)] call _fnc_errorAndClose;
};

_logic setVariable [QGVAR(vehicles), _vehicles];

private _ctrlGrid = _display displayCtrl IDC_FIREMISSION_TARGET_GRID;
_ctrlGrid ctrlSetText _grid;

private _ctrlMode = _display displayCtrl IDC_FIREMISSION_MODE;
private _ctrlTarget = _display displayCtrl IDC_FIREMISSION_TARGET_LOGIC;

if (QGVAR(moduleCreateTarget) call EFUNC(position_logics,exists)) then {
    private _fnc_onModeChanged = {
        params ["_ctrlMode", "_index"];

        private _display = ctrlParent _ctrlMode;

        private _ctrlGrid = _display displayCtrl IDC_FIREMISSION_TARGET_GRID;
        _ctrlGrid ctrlShow (_index == 0);

        private _ctrlTarget = _display displayCtrl IDC_FIREMISSION_TARGET_LOGIC;
        _ctrlTarget ctrlShow (_index == 1);

        private _ctrlLabel = _display displayCtrl IDC_FIREMISSION_TARGET_LABEL;
        _ctrlLabel ctrlSetText localize (["str_3den_display3den_menubar_grid_text", LSTRING(ModuleFireMission_Target)] select _index);
    };

    _ctrlMode ctrlAddEventHandler ["ToolBoxSelChanged", _fnc_onModeChanged];
    _ctrlMode lbSetCurSel _mode;

    [_ctrlMode, _mode] call _fnc_onModeChanged;

    [_ctrlTarget, QGVAR(moduleCreateTarget), _target, false, _logic] call EFUNC(position_logics,initList);
} else {
    _ctrlTarget ctrlShow false;
    _ctrlMode ctrlSetTooltip localize LSTRING(NoTargetModules);
    _ctrlMode ctrlSetBackgroundColor [0, 0, 0, 0.25];
    _ctrlMode ctrlSetFade 0.3;
    _ctrlMode ctrlCommit 0;
    _ctrlMode ctrlEnable false;
};

private _ctrlSpreadSlider = _display displayCtrl IDC_FIREMISSION_SPREAD_SLIDER;
private _ctrlSpreadEdit   = _display displayCtrl IDC_FIREMISSION_SPREAD_EDIT;
[_ctrlSpreadSlider, _ctrlSpreadEdit, 0, 1000, _spread, 10] call EFUNC(common,initSliderEdit);

private _ctrlUnits = _display displayCtrl IDC_FIREMISSION_UNITS;

for "_i" from 1 to (count _vehicles) do {
    _ctrlUnits lbAdd str _i;
};

_ctrlUnits lbSetCurSel (lbSize _ctrlUnits min _units) - 1;

private _ctrlAmmo = _display displayCtrl IDC_FIREMISSION_AMMO;
private _cfgMagazines = configFile >> "CfgMagazines";
private _artilleryAmmo = if (_vehicle call EFUNC(common,isVLS)) then {
    magazines _vehicle
} else {
    getArtilleryAmmo _vehicles
};

{
    private _index = _ctrlAmmo lbAdd (getText (_cfgMagazines >> _x >> "displayName"));
    _ctrlAmmo lbSetData [_index, _x];
} forEach _artilleryAmmo;

_ctrlAmmo lbSetCurSel ((_artilleryAmmo find _ammo) max 0);

private _ctrlRounds = _display displayCtrl IDC_FIREMISSION_ROUNDS;
_ctrlRounds ctrlSetText str _rounds;

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

    private _ctrlMode = _display displayCtrl IDC_FIREMISSION_MODE;
    private _mode = lbCurSel _ctrlMode;

    private _ctrlGrid = _display displayCtrl IDC_FIREMISSION_TARGET_GRID;
    private _grid = ctrlText _ctrlGrid;

    private _ctrlTarget = _display displayCtrl IDC_FIREMISSION_TARGET_LOGIC;
    private _target = _ctrlTarget lbValue lbCurSel _ctrlTarget;

    private _ctrlSpreadSlider = _display displayCtrl IDC_FIREMISSION_SPREAD_SLIDER;
    private _spread = sliderPosition _ctrlSpreadSlider;

    private _ctrlUnits = _display displayCtrl IDC_FIREMISSION_UNITS;
    private _numberOfUnits = lbCurSel _ctrlUnits + 1;

    private _ctrlAmmo = _display displayCtrl IDC_FIREMISSION_AMMO;
    private _ammo = _ctrlAmmo lbData lbCurSel _ctrlAmmo;

    private _ctrlRounds = _display displayCtrl IDC_FIREMISSION_ROUNDS;
    private _rounds = parseNumber ctrlText _ctrlRounds;

    GVAR(lastFireMission) = [_mode, _grid, _target, _spread, _numberOfUnits, _ammo, _rounds];

    private _vehicles = _logic getVariable QGVAR(vehicles);
    _vehicles = _vehicles select {alive _x && {_ammo in getArtilleryAmmo [_x] || {_ammo in magazines _x}}};
    _vehicles resize (_numberOfUnits min count _vehicles);

    _target = [QGVAR(moduleCreateTarget), _target, _logic] call EFUNC(position_logics,select);

    [_vehicles, [_grid, _target] select _mode, _spread, _ammo, _rounds] call FUNC(moduleFireMission);

    deleteVehicle _logic;
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
