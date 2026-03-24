#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles pressing the edit button in the custom compositions panel.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_compositions_fnc_buttonEdit
 *
 * Public: No
 */

params ["_ctrlEdit"];

private _display = ctrlParent _ctrlEdit;
private _ctrlTree = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY;
private _path = tvCurSel _ctrlTree;

private _category = _ctrlTree tvText GET_PARENT_PATH(_path);
private _name     = _ctrlTree tvText _path;

private _composition = GET_COMPOSITION(_category,_name);

if (!isNil "_composition") then {
    ["edit", [_category, _name, _composition]] call FUNC(openDisplay);
};
