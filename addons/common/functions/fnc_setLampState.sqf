#include "script_component.hpp"
/*
 * Author: mharis001
 * Sets the state (on/off) of the given lamp object.
 *
 * Arguments:
 * 0: Lamp <OBJECT>
 * 1: State <BOOL>
 * 2: Damage <BOOL> (default: false)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_lamp, false] call zen_common_fnc_setLampState
 *
 * Public: No
 */

#define LAMP_DISABLE_DAMAGE 0.95

params ["_lamp", "_state", ["_damage", false]];

if (_damage) then {
    private _damage = [LAMP_DISABLE_DAMAGE, 0] select _state;

    {
        _lamp setHit [_x, _damage];
    } forEach (_lamp call FUNC(getLightingSelections));
};

private _mode = ["OFF", "ON"] select _state;
_lamp switchLight _mode;
