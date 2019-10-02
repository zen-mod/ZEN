#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles updating the positions of area marker icons.
 *
 * Arguments:
 * 0: Map <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_area_markers_fnc_onDraw
 *
 * Public: No
 */

BEGIN_COUNTER(onDraw);

params ["_ctrlMap"];

{
    private _ctrlIcon = GVAR(icons) getVariable _x;

    if (!isNil "_ctrlIcon") then {
        (_ctrlMap ctrlMapWorldToScreen markerPos _x) params ["_posX", "_posY"];

        _ctrlIcon ctrlSetPosition [_posX - OFFSET_X, _posY - OFFSET_Y];
        _ctrlIcon ctrlCommit 0;
    };
} forEach GVAR(markers);

END_COUNTER(onDraw);
