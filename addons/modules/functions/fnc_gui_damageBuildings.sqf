/*
 * Author: mharis001
 * Initializes the "Damage Buildings" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_modules_fnc_gui_damageBuildings
 *
 * Public: No
 */
#include "script_component.hpp"

#define IDCS_CHECKBOXES [IDC_DAMAGEBUILDINGS_UNDAMAGED, IDC_DAMAGEBUILDINGS_DAMAGED_1, IDC_DAMAGEBUILDINGS_DAMAGED_2, IDC_DAMAGEBUILDINGS_DAMAGED_3, IDC_DAMAGEBUILDINGS_DESTROYED]

params ["_display"];

private _ctrlButtonOK = _display displayCtrl IDC_OK;
private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

// Verify a building is near the module
private _building = nearestObject [_logic, "Building"];
TRACE_1("Building",_building);

scopeName "Main";
private _fnc_errorAndClose = {
    params ["_msg"];
    _display closeDisplay 0;
    deleteVehicle _logic;
    [_msg] call EFUNC(common,showMessage);
    breakOut "Main";
};

if (isNull _building) then {
    [LSTRING(BuildingTooFar)] call _fnc_errorAndClose;
};

// Get building type hitzone info
private _buildingConfig = configFile >> "CfgVehicles" >> typeOf _building >> "HitPoints";
private _hasHitzone1 = isClass (_buildingConfig >> "Hitzone_1_hitpoint");
private _hasHitzone2 = isClass (_buildingConfig >> "Hitzone_2_hitpoint");

_logic setVariable [QGVAR(building), _building];
_logic setVariable [QGVAR(damageStates), [true, _hasHitzone1, _hasHitzone2, _hasHitzone1 && _hasHitzone2, true]];

private _fnc_onToolBoxSelChanged = {
    params ["_ctrlMode", "_index"];

    private _display = ctrlParent _ctrlMode;
    private _logic = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
    private _damageStates = _logic getVariable QGVAR(damageStates);
    private _isRadius = _index == 1;

    // Enable edit when in radius mode
    private _ctrlRadius = _display displayCtrl IDC_DAMAGEBUILDINGS_RADIUS;
    _ctrlRadius ctrlEnable _isRadius;

    // Handle disabling damage states incompatible with nearest building
    {
        private _ctrl = _display displayCtrl _x;
        private _enabled = _isRadius || {_damageStates select _forEachIndex};
        _ctrl ctrlEnable _enabled;

        // Default to undamaged if checked state is not available
        if (!_enabled && {cbChecked _ctrl}) then {
            private _ctrlUndamaged = _display displayCtrl IDC_DAMAGEBUILDINGS_UNDAMAGED;
            _ctrlUndamaged cbSetChecked true;
            _ctrl cbSetChecked false;
        };
    } forEach IDCS_CHECKBOXES;
};

private _ctrlMode = _display displayCtrl IDC_DAMAGEBUILDINGS_MODE;
_ctrlMode ctrlAddEventHandler ["ToolBoxSelChanged", _fnc_onToolBoxSelChanged];
[_ctrlMode, 0] call _fnc_onToolBoxSelChanged;

private _ctrlRadius = _display displayCtrl IDC_DAMAGEBUILDINGS_RADIUS;
_ctrlRadius ctrlSetText "100";

private _fnc_onCheckedChanged = {
    params ["_ctrlCheckbox"];

    private _display = ctrlParent _ctrlCheckbox;

    {
        private _ctrl = _display displayCtrl _x;
        _ctrl cbSetChecked false;
    } forEach IDCS_CHECKBOXES;

    _ctrlCheckbox cbSetChecked true;
};

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlAddEventHandler ["CheckedChanged", _fnc_onCheckedChanged];
} forEach IDCS_CHECKBOXES;

private _ctrlUndamaged = _display displayCtrl IDC_DAMAGEBUILDINGS_UNDAMAGED;
_ctrlUndamaged cbSetChecked true;

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

    private _ctrlMode = _display displayCtrl IDC_DAMAGEBUILDINGS_MODE;
    private _selectionMode = lbCurSel _ctrlMode;

    private _ctrlRadius = _display displayCtrl IDC_DAMAGEBUILDINGS_RADIUS;
    private _radius = parseNumber ctrlText _ctrlRadius;

    private _damageState = IDCS_CHECKBOXES findIf {cbChecked (_display displayCtrl _x)};

    private _ctrlEffects = _display displayCtrl IDC_DAMAGEBUILDINGS_EFFECTS;
    private _useEffects = lbCurSel _ctrlEffects > 0;

    private _buildings = if (_selectionMode == 1) then {
        _logic nearObjects ["Building", _radius];
    } else {
        [_logic getVariable QGVAR(building)];
    };

    [_buildings, _damageState, _useEffects] call FUNC(moduleDamageBuildings);
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
