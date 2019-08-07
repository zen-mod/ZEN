#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the garage button.
 *
 * Arguments:
 * 0: Button <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_attributes_fnc_buttonGarage
 *
 * Public: No
 */

params ["_ctrlButton"];

private _display = ctrlParent _ctrlButton;
_display closeDisplay IDC_CANCEL;

private _vehicle = GETMVAR(BIS_fnc_initCuratorAttributes_target,objNull);
[_vehicle] call EFUNC(garage,openGarage);
