#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles hiding the editor preview image when the mouse exits a tree.
 *
 * Arguments:
 * 0: Tree <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_editor_previews_fnc_handleMouseExit
 *
 * Public: No
 */

params ["_ctrlTree"];

private _display = ctrlParent _ctrlTree;
private _ctrlGroup = _display displayCtrl IDC_PREVIEW_GROUP;
_ctrlGroup ctrlShow false;
