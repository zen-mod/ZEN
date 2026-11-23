#include "script_component.hpp"
/*
 * Author: Brett
 * Normalizes and groups the given weapons into a weapon cargo array.
 * Identical weapon configurations (same attachments and magazines) are grouped together.
 *
 * Arguments:
 * 0: Weapons <ARRAY>
 *   - Class names or weapon items arrays.
 * 1: Counts <ARRAY> (default: [])
 *   - Missing counts default to 1.
 *
 * Return Value:
 * Weapon Cargo <ARRAY>
 *
 * Example:
 * [weaponsItemsCargo _object] call zen_inventory_fnc_groupWeapons
 *
 * Public: No
 */

params ["_weapons", ["_counts", []]];

private _types = [];
private _groupedCounts = [];

{
    private _weapon = [_x] call FUNC(normalizeWeapon);
    private _count = _counts param [_forEachIndex, 1];
    private _index = _types find _weapon;

    if (_index == -1) then {
        _types pushBack _weapon;
        _groupedCounts pushBack _count;
    } else {
        _groupedCounts set [_index, (_groupedCounts select _index) + _count];
    };
} forEach _weapons;

[_types, _groupedCounts]
