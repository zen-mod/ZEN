#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Execute Code" Zeus module display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, LOGIC] call zen_modules_fnc_gui_executeCode
 *
 * Public: No
 */

#define VAR_HISTORY QGVAR(executeCodeHistory)
#define MAX_STATEMENTS 20
#define PREVIEW_LENGTH 50

params ["_display", "_logic"];

if (!IS_ADMIN && {missionNamespace getVariable ["ZEN_disableCodeExecution", false]}) exitWith {
    [LSTRING(ModuleExecuteCode_Disabled)] call EFUNC(common,showMessage);
    deleteVehicle _logic;
};

_display setVariable [QGVAR(params), [_logic, [getPosASL _logic, attachedTo _logic]]];

private _ctrlHistory = _display displayCtrl IDC_EXECUTECODE_HISTORY;
_ctrlHistory ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlHistory", "_index"];

    private _display = ctrlParent _ctrlHistory;
    private _history = profileNamespace getVariable [VAR_HISTORY, []];

    private _ctrlEdit = _display displayCtrl IDC_EXECUTECODE_EDIT;
    _ctrlEdit ctrlSetText (_history param [_index, ""]);
}];

{
    if (count _x > PREVIEW_LENGTH) then {
        _x = (_x select [0, PREVIEW_LENGTH]) + toString [46, 46, 46];
    };

    _ctrlHistory lbAdd _x;
} forEach (profileNamespace getVariable [VAR_HISTORY, []]);

_ctrlHistory lbSetCurSel 0;

private _fnc_onUnload = {
    params ["_display", "_exitCode"];
    (_display getVariable QGVAR(params)) params ["_logic"];

    if (_exitCode == IDC_CANCEL) then {
        deleteVehicle _logic;
    };
};

_display displayAddEventHandler ["Unload", _fnc_onUnload];

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    (_display getVariable QGVAR(params)) params ["_logic", "_args"];

    private _code = ctrlText (_display displayCtrl IDC_EXECUTECODE_EDIT);
    private _mode = lbCurSel (_display displayCtrl IDC_EXECUTECODE_MODE);

    private _history = profileNamespace getVariable [VAR_HISTORY, []];
    _history deleteAt (_history find _code);

    reverse _history;
    _history pushBack _code;
    reverse _history;

    if (count _history > MAX_STATEMENTS) then {
        _history resize MAX_STATEMENTS;
    };

    profileNamespace setVariable [VAR_HISTORY, _history];

    _code = compile _code;

    switch (_mode) do {
        case 0: {
            _args call _code;
        };
        case 1: {
            [QEGVAR(common,execute), [_code, _args]] call CBA_fnc_serverEvent;
        };
        case 2: {
            [QEGVAR(common,execute), [_code, _args]] call CBA_fnc_globalEvent;
        };
        case 3: {
            private _jipID = [QEGVAR(common,execute), [_code, _args]] call CBA_fnc_globalEventJIP;
            [_jipID, _logic] call CBA_fnc_removeGlobalEventJIP;

            private _jipID = [QEGVAR(common,setName), [_logic, format ["JIP ID - %1", _jipID]]] call CBA_fnc_globalEventJIP;
            [_jipID, _logic] call CBA_fnc_removeGlobalEventJIP;
        };
    };

    if (_mode == 3) then {
        _logic setVariable [QEGVAR(attributes,disabled), true, true];
    } else {
        deleteVehicle _logic;
    };
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
