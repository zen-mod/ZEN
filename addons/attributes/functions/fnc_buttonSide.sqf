#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the side button.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_attributes_fnc_buttonSide
 *
 * Public: No
 */

private _group = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

[LSTRING(ChangeSide), [
    ["SIDES", ELSTRING(common,Side), side _group, true]
], {
    params ["_dialogValues"];
    _dialogValues params ["_side"];

    {
        [_x, _side] call EFUNC(common,changeGroupSide);
    } forEach SELECTED_GROUPS;
}] call EFUNC(dialog,create);
