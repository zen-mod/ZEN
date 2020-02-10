#include "script_component.hpp"
/*
 * Author: Brett, mharis001
 * Handles changing the selection in an object tree.
 *
 * Arguments:
 * 0: Tree <CONTROL>
 * 1: Selected Path <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, []] call zen_placement_fnc_handleTreeSelect
 *
 * Public: No
 */

params ["_ctrlTree", "_selectedPath"];

// Setup the preview with if object placement is active
// Otherwise delete the current preview
private _objectType = if (count _selectedPath == 3) then {
    _ctrlTree tvData _selectedPath
} else {
    ""
};

[_objectType] call FUNC(setupPreview);
