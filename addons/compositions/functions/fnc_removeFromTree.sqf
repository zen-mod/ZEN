#include "script_component.hpp"
/*
 * Author: mharis001
 * Removes the currently selected custom composition from the compositions tree.
 *
 * Arguments:
 * 0: Delete From Data <BOOL> (default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [false] call zen_compositions_fnc_removeFromTree
 *
 * Public: No
 */

params [["_deleteFromData", true]];

private _ctrlTree = findDisplay IDD_RSCDISPLAYCURATOR displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_GROUPS_EMPTY;
private _path = tvCurSel _ctrlTree;

// Exit if the path is not a custom composition
if (_ctrlTree tvData _path != COMPOSITION_STR) exitWith {};

// Get the category and name of the selected composition
private _category = _ctrlTree tvText GET_PARENT_PATH(_path);
private _name     = _ctrlTree tvText _path;

// Delete the composition from the tree
_ctrlTree tvDelete _path;
private _compositions = GET_COMPOSITIONS;
private _categoryHash = _compositions get _category;

// Delete the composition from saved data if needed
if (_deleteFromData) then {
    _categoryHash deleteAt _name;
};

// Delete the category from the tree if no more compositions exist under it
if (keys _categoryHash isEqualTo []) then {
    private _categories = _ctrlTree getVariable [QGVAR(categories), []];
    _categories deleteAt (_categories find _category);

    _compositions deleteAt _category;
    _ctrlTree tvDelete GET_PARENT_PATH(_path);
};

// Manually trigger tree selection change
[_ctrlTree, tvCurSel _ctrlTree] call FUNC(handleTreeSelect);
