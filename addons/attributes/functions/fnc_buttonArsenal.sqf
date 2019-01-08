/*
 * Author: mharis001
 * Handles clicking the arsenal button.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_buttonArsenal
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_ctrlButton"];

private _display = ctrlParent _ctrlButton;
_display closeDisplay IDC_CANCEL;

private _unit = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);

if (EGVAR(common,useAceArsenal)) then {
    [_unit, _unit, true] call ace_arsenal_fnc_openBox;
} else {
    ["Open", [true, nil, _unit]] call BIS_fnc_arsenal;
};
