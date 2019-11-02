#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to damage buildings.
 *
 * Arguments:
 * 0: Buildings <ARRAY>
 * 1: Damage state <NUMBER>
 *    - 0 = Undamaged
 *    - 1 = Damaged 1
 *    - 2 = Damaged 2
 *    - 3 = Damaged 1 & 2
 *    - 4 = Destroyed
 * 2: Use effects <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[building1, building2], 4, true] call zen_modules_fnc_moduleDamageBuildings
 *
 * Public: No
 */

params ["_buildings", "_damageState", "_useEffects"];

private _cfgVehicles = configFile >> "CfgVehicles";

{
    private _building = _x;
    private _buildingConfig = _cfgVehicles >> typeOf _building >> "HitPoints";
    private _noHitzone1 = !isClass (_buildingConfig >> "Hitzone_1_hitpoint");
    private _noHitzone2 = !isClass (_buildingConfig >> "Hitzone_2_hitpoint");

    // Some buildings might not have selected damage state
    // Fallback to undamaged in that case
    private _stateToApply = _damageState;
    if (
        _damageState == 1 && _noHitzone1
        || {_damageState == 2 && _noHitzone2}
        || {_damageState == 3 && (_noHitzone1 || _noHitzone2)}
    ) then {
        _stateToApply = 0;
    };

    switch (_stateToApply) do {
        case 0: {
            _building setDamage [0, _useEffects];
        };
        case 1: {
            _building setHitPointDamage ["Hitzone_1_hitpoint", 1, _useEffects];
        };
        case 2: {
            _building setHitPointDamage ["Hitzone_2_hitpoint", 1, _useEffects];
        };
        case 3: {
            _building setHitPointDamage ["Hitzone_1_hitpoint", 1, _useEffects];
            _building setHitPointDamage ["Hitzone_2_hitpoint", 1, _useEffects];
        };
        case 4: {
            _building setDamage [1, _useEffects];
        };
    };
} forEach _buildings;
