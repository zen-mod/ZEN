#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Damage Buildings" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_modules_fnc_gui_damageBuildings
 *
 * Public: No
 */

#define IDCS_STATES [IDC_DAMAGEBUILDINGS_UNDAMAGED, IDC_DAMAGEBUILDINGS_DAMAGED_1, IDC_DAMAGEBUILDINGS_DAMAGED_2, IDC_DAMAGEBUILDINGS_DAMAGED_3, IDC_DAMAGEBUILDINGS_DESTROYED]

params ["_display", "_logic"];

private _selections = GVAR(saved) getVariable [QGVAR(damageBuildings), [0, 100, 0, [true, false, false, false, false]]];
_selections params ["_mode", "_radius", "_useEffects", "_states"];

private _building = nearestObject [_logic, "Building"];
_display setVariable [QGVAR(params), [_building, ASLToAGL getPosASL _logic]];
deleteVehicle _logic;

private _fnc_stateSelected = {
    params ["_ctrlState"];

    private _display = ctrlParent _ctrlState;

    {
        (_display displayCtrl _x) cbSetChecked false;
    } forEach IDCS_STATES;

    _ctrlState cbSetChecked true;
};

{
    private _ctrlState = _display displayCtrl _x;
    _ctrlState ctrlAddEventHandler ["CheckedChanged", _fnc_stateSelected];
    _ctrlState cbSetChecked (_states select _forEachIndex);
} forEach IDCS_STATES;

private _ctrlMode = _display displayCtrl IDC_DAMAGEBUILDINGS_MODE;

if (isNull _building) then {
    // Disable mode selection if no building is within 50 m
    _ctrlMode lbSetCurSel 1;
    _ctrlMode ctrlSetFade 0.5;
    _ctrlMode ctrlEnable false;
    _ctrlMode ctrlCommit 0;
} else {
    // Get the available damage states for the nearest building
    private _config = configOf _building >> "HitPoints";
    private _hasHitzone1 = isClass (_config >> "Hitzone_1_hitpoint");
    private _hasHitzone2 = isClass (_config >> "Hitzone_2_hitpoint");

    _display setVariable [QGVAR(states), [true, _hasHitzone1, _hasHitzone2, _hasHitzone1 && _hasHitzone2, true]];

    private _fnc_modeChanged = {
        params ["_ctrlMode", "_index"];

        private _display = ctrlParent _ctrlMode;
        private _states = _display getVariable QGVAR(states);
        private _isRadius = _index == 1;

        private _ctrlRadius = _display displayCtrl IDC_DAMAGEBUILDINGS_RADIUS;
        _ctrlRadius ctrlEnable _isRadius;

        // Disable damage states that the nearest building does not support
        {
            private _ctrlState = _display displayCtrl _x;
            private _enabled = _isRadius || {_states select _forEachIndex};
            _ctrlState ctrlEnable _enabled;

            // Default to undamaged if the selected state is unavailable
            if (!_enabled && {cbChecked _ctrlState}) then {
                private _ctrlUndamaged = _display displayCtrl IDC_DAMAGEBUILDINGS_UNDAMAGED;
                _ctrlUndamaged cbSetChecked true;

                _ctrlState cbSetChecked false;
            };
        } forEach IDCS_STATES;
    };

    private _ctrlMode = _display displayCtrl IDC_DAMAGEBUILDINGS_MODE;
    _ctrlMode ctrlAddEventHandler ["ToolBoxSelChanged", _fnc_modeChanged];
    _ctrlMode lbSetCurSel _mode;

    [_ctrlMode, _mode] call _fnc_modeChanged;
};

private _ctrlRadius = _display displayCtrl IDC_DAMAGEBUILDINGS_RADIUS;
_ctrlRadius ctrlSetText str _radius;

private _ctrlEffects = _display displayCtrl IDC_DAMAGEBUILDINGS_EFFECTS;
_ctrlEffects lbSetCurSel _useEffects;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    (_display getVariable QGVAR(params)) params ["_building", "_position"];

    private _ctrlMode = _display displayCtrl IDC_DAMAGEBUILDINGS_MODE;
    private _mode = lbCurSel _ctrlMode;

    private _ctrlRadius = _display displayCtrl IDC_DAMAGEBUILDINGS_RADIUS;
    private _radius = parseNumber ctrlText _ctrlRadius;

    private _ctrlEffects = _display displayCtrl IDC_DAMAGEBUILDINGS_EFFECTS;
    private _useEffects = lbCurSel _ctrlEffects;

    private _states = IDCS_STATES apply {cbChecked (_display displayCtrl _x)};

    private _selections = [_mode, _radius, _useEffects, _states];
    GVAR(saved) setVariable [QGVAR(damageBuildings), _selections];

    private _buildings = if (_mode == 1) then {
        _position nearObjects ["Building", _radius]
    } else {
        [_building]
    };

    [_buildings, _states findIf {_x}, _useEffects > 0] call FUNC(moduleDamageBuildings);
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
