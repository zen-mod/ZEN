#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the "Exec" Zeus attribute.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_attributes_fnc_attributeExec
 *
 * Public: No
 */

#define VAR_HISTORY QGVAR(attributeExecHistory)
#define MAX_STATEMENTS 20
#define PREVIEW_LENGTH 30

params ["_display"];

if (!IS_ADMIN && {missionNamespace getVariable ["ZEN_disableCodeExecution", false]}) exitWith {
    private _ctrlExec = _display displayCtrl IDC_EXEC;
    _ctrlExec ctrlShow false;
};

private _ctrlHistory = _display displayCtrl IDC_EXEC_HISTORY;
_ctrlHistory ctrlAddEventHandler ["LBSelChanged", {
    params ["_ctrlHistory", "_index"];

    private _display = ctrlParent _ctrlHistory;
    private _ctrlEdit = _display displayCtrl IDC_EXEC_EDIT;

    private _text = if (_index > 0) then {
        private _history = profileNamespace getVariable [VAR_HISTORY, []];
        _history select (_index - 1)
    } else {
        "" // new
    };

    _ctrlEdit ctrlSetText _text;
}];

_ctrlHistory lbAdd localize "STR_A3_RscAttributeTaskDescription_New";

{
    if (count _x > PREVIEW_LENGTH) then {
        _x = (_x select [0, PREVIEW_LENGTH]) + toString [46, 46, 46];
    };

    _ctrlHistory lbAdd _x;
} forEach (profileNamespace getVariable [VAR_HISTORY, []]);

_ctrlHistory lbSetCurSel 0;

private _fnc_onConfirm = {
    params ["_ctrlButtonOK"];

    private _display = ctrlParent _ctrlButtonOK;
    private _entity = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

    private _ctrlEdit = _display displayCtrl IDC_EXEC_EDIT;
    private _code = ctrlText _ctrlEdit;
    if (_code == "") exitWith {};

    private _history = profileNamespace getVariable [VAR_HISTORY, []];
    _history deleteAt (_history find _code);

    reverse _history;
    _history pushBack _code;
    reverse _history;

    if (count _history > MAX_STATEMENTS) then {
        _history resize MAX_STATEMENTS;
    };

    profileNamespace setVariable [VAR_HISTORY, _history];

    [QEGVAR(common,execute), [compile _code, _entity], _entity] call CBA_fnc_targetEvent;
};

private _ctrlButtonOK = _display displayCtrl IDC_OK;
_ctrlButtonOK ctrlAddEventHandler ["ButtonClick", _fnc_onConfirm];
