/*
 * Author: mharis001
 * Initializes the TOOLBOX content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Row Index <NUMBER>
 * 2: Current Value <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, true] call zen_dialog_fnc_gui_toolbox
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_controlsGroup", "_rowIndex", "_currentValue"];

private _ctrlToolbox = _controlsGroup controlsGroupCtrl IDC_ROW_TOOLBOX;
_ctrlToolbox lbSetCurSel parseNumber _currentValue;

_ctrlToolbox setVariable [QGVAR(params), [_rowIndex]];
_ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlToolbox", "_index"];
    (_ctrlToolbox getVariable QGVAR(params)) params ["_rowIndex"];

    private _display = ctrlParent _ctrlToolbox;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _index == 1];
}];
