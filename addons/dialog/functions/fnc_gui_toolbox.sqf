#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the TOOLBOX content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Row Index <NUMBER>
 * 2: Current Value <NUMBER|BOOL>
 * 3: Row Settings <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, true, [["No", "Yes", true]]] call zen_dialog_fnc_gui_toolbox
 *
 * Public: No
 */

params ["_controlsGroup", "_rowIndex", "_currentValue", "_rowSettings"];
_rowSettings params ["_strings", "_returnBool"];

private _ctrlToolbox = _controlsGroup controlsGroupCtrl IDC_ROW_TOOLBOX;

// Currently the only way to add options to toolbox controls through script
// Unfortunately also sets the name as the tooltip
{
    _ctrlToolbox lbAdd _x;
} forEach _strings;

// Need number to set current index
if (_returnBool) then {
    _currentValue = parseNumber _currentValue;
};

_ctrlToolbox lbSetCurSel _currentValue;

_ctrlToolbox setVariable [QGVAR(params), [_rowIndex, _returnBool]];
_ctrlToolbox ctrlAddEventHandler ["ToolBoxSelChanged", {
    params ["_ctrlToolbox", "_value"];
    (_ctrlToolbox getVariable QGVAR(params)) params ["_rowIndex", "_returnBool"];

    if (_returnBool) then {
        _value = _value > 0;
    };

    private _display = ctrlParent _ctrlToolbox;
    private _values = _display getVariable QGVAR(values);
    _values set [_rowIndex, _value];
}];
