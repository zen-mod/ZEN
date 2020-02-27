#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles changing the selection in the custom markers tree.
 *
 * Arguments:
 * 0: Markers Tree <CONTROL>
 * 1: Selected Path <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_markers_tree_fnc_handleCustomSelect
 *
 * Public: No
 */

params ["_ctrlTreeCustom", "_selectedPath"];

private _display = ctrlParent _ctrlTreeCustom;
private _ctrlTreeEngine = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MARKERS;

// Fix keyboard input changing tree selection
private _focusIDC = [IDC_RSCDISPLAYCURATOR_MOUSEAREA, IDC_RSCDISPLAYCURATOR_MAINMAP] select visibleMap;
ctrlSetFocus (_display displayCtrl _focusIDC);

if (count _selectedPath != 2) exitWith {
    _ctrlTreeEngine tvSetCurSel [-1];
};

private _class = _ctrlTreeCustom tvData _selectedPath;

for "_i" from 0 to ((_ctrlTreeEngine tvCount []) - 1) do {
    if (_ctrlTreeEngine tvData [_i] == _class) exitWith {
        _ctrlTreeEngine tvSetCurSel [_i];
    };
};
