#include "script_component.hpp"
/*
 * Author: Ampersand, mharis001
 * Initializes the "Tracers" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_modules_fnc_gui_tracers
 *
 * Public: No
 */

params ["_display", "_logic"];

// Get the current tracer parameters (use default if module has not been initialized yet)
private _params = _logic getVariable QGVAR(tracersParams);
private _isInit = isNil "_params";

if (_isInit) then {
    _params = ["LMG_Mk200_F", "200Rnd_65x39_cased_Box_Tracer_Red", [5, 10, 15], 2, objNull];
};

_params params ["_weapon", "_magazine", "_delay", "_dispersion", "_target"];

// Store the logic and target (in case the target is not changed)
_display setVariable [QGVAR(params), [_logic, _target]];

// Common function to populate weapon and magazine lists with entries
private _fnc_populateList = {
    params ["_ctrlList", "_entries", "_baseConfig"];

    lnbClear _ctrlList;

    {
        private _config = _baseConfig >> _x;
        private _name = getText (_config >> "displayName");
        private _icon = getText (_config >> "picture");

        private _index = _ctrlList lnbAddRow ["", _name];
        _ctrlList lnbSetTooltip [[_index, 0], format ["%1\n%2", _name, _x]];
        _ctrlList lnbSetPicture [[_index, 0], _icon];
        _ctrlList lnbSetData [[_index, 0], _x];

        private _mod = [_config] call EFUNC(common,getDLC);

        if (_mod != "") then {
            private _logo = modParams [_mod, ["logo"]] param [0, ""];
            _ctrlList lnbSetPicture [[_index, 2], _logo];
        };
    } forEach _entries;

    _ctrlList lnbSort [1];
    _ctrlList lnbSetCurSelRow 0;
};

_display setVariable [QFUNC(populateList), _fnc_populateList];

// Populate the weapons list
private _ctrlWeapon = _display displayCtrl IDC_TRACERS_WEAPON;
private _weapons = keys (uiNamespace getVariable QGVAR(tracersCache));
[_ctrlWeapon, _weapons, configFile >> "CfgWeapons"] call _fnc_populateList;

// Refresh the magazines list when a weapon is selected
_ctrlWeapon ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlWeapon", "_index"];

    private _display = ctrlParent _ctrlWeapon;
    private _weapon = _ctrlWeapon lnbData [_index, 0];
    private _fnc_populateList = _display getVariable QFUNC(populateList);

    private _ctrlMagazine = _display displayCtrl IDC_TRACERS_MAGAZINE;
    private _magazines = uiNamespace getVariable QGVAR(tracersCache) get _weapon;
    [_ctrlMagazine, _magazines, configFile >> "CfgMagazines"] call _fnc_populateList;
}];

// Select the current weapon in the list (also initially populates magazines list)
for "_i" from 0 to (lnbSize _ctrlWeapon select 0) - 1 do {
    if (_ctrlWeapon lnbData [_i, 0] == _weapon) exitWith {
        _ctrlWeapon lnbSetCurSelRow _i;
    };
};

// Select the current magazine in the list
private _ctrlMagazine = _display displayCtrl IDC_TRACERS_MAGAZINE;

for "_i" from 0 to (lnbSize _ctrlMagazine select 0) - 1 do {
    if (_ctrlMagazine lnbData [_i, 0] == _magazine) exitWith {
        _ctrlMagazine lnbSetCurSelRow _i;
    };
};

// Populate the burst delay edit boxes with the current values
{
    private _ctrlDelay = _display displayCtrl _x;
    _ctrlDelay ctrlSetText str parseNumber (_delay select _forEachIndex toFixed 3);
} forEach [IDC_TRACERS_DELAY_MIN, IDC_TRACERS_DELAY_MID, IDC_TRACERS_DELAY_MAX];

// Select the current dispersion value
private _ctrlDispersion = _display displayCtrl IDC_TRACERS_DISPERSION;
_ctrlDispersion lbSetCurSel _dispersion;

// Initialize the target toolbox based on if the module has been initialized already
private _ctrlTarget = _display displayCtrl IDC_TRACERS_TARGET;
private _ctrlChange = _display displayCtrl IDC_TRACERS_CHANGE;

if (_isInit) then {
    // Hide the change target checkbox if the module has not been initialized
    // In this situation, the user must select a target
    _ctrlChange cbSetChecked true;
    _ctrlChange ctrlShow false;
} else {
    // Enable the target toolbox when change target checkbox is checked
    _ctrlChange ctrlAddEventHandler ["CheckedChanged", {
        params ["_ctrlChange", "_checked"];

        private _display = ctrlParent _ctrlChange;
        private _enabled = _checked == 1;

        private _ctrlTarget = _display displayCtrl IDC_TRACERS_TARGET;
        _ctrlTarget ctrlEnable _enabled;

        private _ctrlOverlay = _display getVariable QGVAR(overlay);
        _ctrlOverlay ctrlShow !_enabled;
    }];

    // Disable the target toolbox to leave the target unchanged by default
    _ctrlTarget ctrlEnable false;

    // Toolbox control by default does not look different when disabled
    // Using an overlay control to better convey when the toolbox is disabled
    private _ctrlOverlay = _display ctrlCreate ["RscText", -1, ctrlParentControlsGroup _ctrlTarget];
    _ctrlOverlay ctrlSetBackgroundColor [0, 0, 0, 0.5];
    _ctrlOverlay ctrlSetPosition ctrlPosition _ctrlTarget;
    _ctrlOverlay ctrlCommit 0;

    _display setVariable [QGVAR(overlay), _ctrlOverlay];
};

// Confirm options when the OK button is clicked
private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    (_display getVariable QGVAR(params)) params ["_logic", "_target"];

    private _ctrlWeapon = _display displayCtrl IDC_TRACERS_WEAPON;
    private _weapon = _ctrlWeapon lnbData [lnbCurSelRow _ctrlWeapon, 0];

    private _ctrlMagazine = _display displayCtrl IDC_TRACERS_MAGAZINE;
    private _magazine = _ctrlMagazine lnbData [lnbCurSelRow _ctrlMagazine, 0];

    private _delay = [IDC_TRACERS_DELAY_MIN, IDC_TRACERS_DELAY_MID, IDC_TRACERS_DELAY_MAX] apply {
        parseNumber ctrlText (_display displayCtrl _x)
    };

    private _dispersion = lbCurSel (_display displayCtrl IDC_TRACERS_DISPERSION);

    // Select tracers target based on checkbox and toolbox state
    private _targetType = if (cbChecked (_display displayCtrl IDC_TRACERS_CHANGE)) then {
        lbCurSel (_display displayCtrl IDC_TRACERS_TARGET)
    } else {
        -1 // Unchanged
    };

    if (_targetType == 2) exitWith {
        [_logic, {
            params ["_successful", "_logic", "_position", "_args"];
            _args params ["_weapon", "_magazine", "_delay", "_dispersion"];

            if (_successful) then {
                curatorMouseOver params ["_type", "_entity"];

                private _target = [_position, _entity] select (_type == "OBJECT");
                [QGVAR(moduleTracers), [_logic, _weapon, _magazine, _delay, _dispersion, _target]] call CBA_fnc_serverEvent;
            };
        }, [_weapon, _magazine, _delay, _dispersion], LSTRING(Tracers_TracersTarget)] call EFUNC(common,selectPosition);
    };

    if (_targetType == 1) then {
        _target = AGLToASL positionCameraToWorld [0, 0, 0];
    };

    if (_targetType == 0) then {
        _target = objNull;
    };

    [QGVAR(moduleTracers), [_logic, _weapon, _magazine, _delay, _dispersion, _target]] call CBA_fnc_serverEvent;
}];
