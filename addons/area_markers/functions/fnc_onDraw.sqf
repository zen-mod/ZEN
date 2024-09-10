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
    (_ctrlMap ctrlMapWorldToScreen markerPos _x) params ["_posX", "_posY"];

    _y ctrlSetPosition [_posX - OFFSET_X, _posY - OFFSET_Y];
    _y ctrlCommit 0;
} forEach GVAR(icons);

END_COUNTER(onDraw);
