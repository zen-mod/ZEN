#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles selecting an item in the empty compositions tree.
 *
 * Arguments:
 * 0: Tree <CONTROL>
 * 1: Selected Path <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, [0]] call zen_compositions_fnc_handleTreeSelect
 *
 * Public: No
 */

params ["_ctrlTree", "_selectedPath"];

// Enable the edit and delete buttons if the selected path is a custom composition
private _display = ctrlParent _ctrlTree;
private _enable = _ctrlTree tvData _selectedPath == COMPOSITION_STR;

{
    private _ctrl = _display displayCtrl _x;
    _ctrl ctrlEnable _enable;
} forEach [IDC_PANEL_EDIT, IDC_PANEL_DELETE];

// If the selected path is a custom composition, get its data for when it is placed
if (_enable) then {
    private _category = _ctrlTree tvText GET_PARENT_PATH(_selectedPath);
    private _name     = _ctrlTree tvText _selectedPath;

    GVAR(selected) = _ctrlTree getVariable [FORMAT_OBJECT_DATA_VAR(_category,_name), []];
};
