#include "script_component.hpp"
/*
 * Author: mharis001
 * Collapses all tree paths for the given tree control.
 * Needed because tvCollapseAll is bugged and results in the scroll bar not
 * automatically showing without selecting a tree item first.
 * This works around that by using tvCollapse on all tree paths.
 *
 * Arguments:
 * 0: Tree Control <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_common_fnc_collapseTree
 *
 * Public: No
 */

params ["_ctrlTree"];

private _fnc_collapse = {
    // Collapsing [] path causes tree to disappear
    if (_this isNotEqualTo []) then {
        _ctrlTree tvCollapse _this;
    };

    for "_i" from 0 to ((_ctrlTree tvCount _this) - 1) do {
        _this + [_i] call _fnc_collapse;
    };
};

[] call _fnc_collapse;
