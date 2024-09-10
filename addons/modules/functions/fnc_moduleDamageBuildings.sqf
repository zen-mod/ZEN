#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to damage buildings.
 *
 * Arguments:
 * 0: Buildings <ARRAY>
 * 1: Damage State <NUMBER>
 *   - 0 = Undamaged
 *   - 1 = Damaged 1
 *   - 2 = Damaged 2
 *   - 3 = Damaged 1 & 2
 *   - 4 = Destroyed
 * 2: Use Effects <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_buildings, 4, true] call zen_modules_fnc_moduleDamageBuildings
 *
 * Public: No
 */

params ["_buildings", "_damageState", "_useEffects"];

{
    private _building = _x;
    private _config = configOf _building >> "HitPoints";
    private _hasHitzone1 = isClass (_config >> "Hitzone_1_hitpoint");
    private _hasHitzone2 = isClass (_config >> "Hitzone_2_hitpoint");

    switch (_damageState) do {
        case 0: {
            _building setDamage [0, _useEffects];
        };
        case 1: {
            if (_hasHitzone1) then {
                _building setHitPointDamage ["Hitzone_1_hitpoint", 1, _useEffects];
            };
        };
        case 2: {
            if (_hasHitzone2) then {
                _building setHitPointDamage ["Hitzone_2_hitpoint", 1, _useEffects];
            };
        };
        case 3: {
            if (_hasHitzone1 && _hasHitzone2) then {
                _building setHitPointDamage ["Hitzone_1_hitpoint", 1, _useEffects];
                _building setHitPointDamage ["Hitzone_2_hitpoint", 1, _useEffects];
            };
        };
        case 4: {
            _building setDamage [1, _useEffects];
        };
    };
} forEach _buildings;
