#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles selecting an animation. Called from LBSelChanged event.
 *
 * Arguments:
 * 0: Animations list <CONTROL>
 * 1: Selected index <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_garage_fnc_onAnimationSelect
 *
 * Public: No
 */

params ["_ctrlListAnimations", "_selectedIndex"];

// Invert selected animation entry
private _value = 1 - (_ctrlListAnimations lbValue _selectedIndex);
_ctrlListAnimations lbSetValue [_selectedIndex, _value];
_ctrlListAnimations lbSetPicture [_selectedIndex, CHECK_ICONS select _value];

// Create array of all animation states
private _animations = [];
for "_i" from 0 to (lbSize _ctrlListAnimations - 1) do {
    private _dataVar = _ctrlListAnimations lbData _i;
    _animations pushBack (_ctrlListAnimations getVariable _dataVar);
    _animations pushBack (_ctrlListAnimations lbValue _i);
};

// Update vehicle animations
[GVAR(center), nil, _animations, true, false] call EFUNC(common,customizeVehicle);
