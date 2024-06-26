#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles updating the visibility of area marker icons.
 *
 * Arguments:
 * 0: Arguments <ARRAY>
 *   0: Current Visibility <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[false]] call zen_area_markers_fnc_onVisibilityPFH
 *
 * Public: No
 */

BEGIN_COUNTER(onVisibilityPFH);

params ["_args"];
_args params ["_oldVisibility"];

private _newVisibility = call FUNC(isInEditMode);

if (_oldVisibility isNotEqualTo _newVisibility) then {
    {
        _y ctrlShow _newVisibility;
    } forEach GVAR(icons);

    _args set [0, _newVisibility];
};

END_COUNTER(onVisibilityPFH);
