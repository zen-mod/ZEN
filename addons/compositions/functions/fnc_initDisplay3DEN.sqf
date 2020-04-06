#include "script_component.hpp"
#include "\a3\3den\ui\resincl.inc"
/*
 * Author: mharis001
 * Initializes the 3DEN Editor display.
 * Handles hiding the helper composition from the 3DEN compositions tree.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_compositions_fnc_initDisplay3DEN
 *
 * Public: No
 */

params ["_display"];

private _fnc_hideComposition = {
    params ["_ctrlCreate"];

    private _display = ctrlParent _ctrlCreate;

    if (lbCurSel (_display displayCtrl IDC_DISPLAY3DEN_MODES) == 1 && {lbCurSel (_display displayCtrl IDC_DISPLAY3DEN_SUBMODES) == 4}) then {
        private _ctrlTree = _display displayCtrl IDC_DISPLAY3DEN_CREATE_GROUP_EMPTY;

        for "_i" from 0 to ((_ctrlTree tvCount []) - 1) do {
            if (_ctrlTree tvData [_i] == CATEGORY_STR) exitWith {
                _ctrlTree tvDelete [_i];
            };
        };
    };
};

private _ctrlCreate = _display displayCtrl IDC_DISPLAY3DEN_PANELRIGHT_CREATE;
_ctrlCreate ctrlAddEventHandler ["MouseMoving", _fnc_hideComposition];
_ctrlCreate ctrlAddEventHandler ["MouseHolding", _fnc_hideComposition];
