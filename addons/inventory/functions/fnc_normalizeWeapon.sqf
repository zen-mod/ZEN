#include "script_component.hpp"
/*
 * Author: Brett
 * Converts the given weapon into a normalized weapon items array.
 * Class names are converted to their base weapon with config linked attachments,
 * weapon items arrays (as returned by weaponsItemsCargo) are converted to use the base weapon
 * and always contain both the primary and secondary muzzle magazine elements.
 *
 * Arguments:
 * 0: Weapon <STRING|ARRAY>
 *
 * Return Value:
 * Weapon Items <ARRAY>
 *   0: Weapon <STRING>
 *   1: Muzzle <STRING>
 *   2: Pointer <STRING>
 *   3: Optic <STRING>
 *   4: Primary Muzzle Magazine <ARRAY>
 *   5: Secondary Muzzle Magazine <ARRAY>
 *   6: Bipod <STRING>
 *
 * Example:
 * ["arifle_MX_ACO_pointer_F"] call zen_inventory_fnc_normalizeWeapon
 *
 * Public: No
 */

params [["_weapon", "", ["", []]]];

private _cfgWeapons = configFile >> "CfgWeapons";

if (_weapon isEqualType "") exitWith {
    // Muzzle, pointer, optic, bipod
    private _attachments = ["", "", "", ""];

    {
        private _index = ["muzzleslot", "pointerslot", "cowsslot", "underbarrelslot"] find toLower getText (_x >> "slot");

        if (_index != -1) then {
            _attachments set [_index, configName (_cfgWeapons >> getText (_x >> "item"))];
        };
    } forEach configProperties [_cfgWeapons >> _weapon >> "LinkedItems", "isClass _x"];

    _attachments params ["_muzzle", "_pointer", "_optic", "_bipod"];

    [_weapon call BIS_fnc_baseWeapon, _muzzle, _pointer, _optic, [], [], _bipod]
};

// The secondary muzzle magazine element can be missing for weapons without a secondary muzzle
if (count _weapon == 6) then {
    _weapon = +_weapon;
    _weapon insert [5, [[]]];
};

_weapon params [
    ["_class", "", [""]],
    ["_muzzle", "", [""]],
    ["_pointer", "", [""]],
    ["_optic", "", [""]],
    ["_primaryMagazine", [], [[]]],
    ["_secondaryMagazine", [], [[]]],
    ["_bipod", "", [""]]
];

[_class call BIS_fnc_baseWeapon, _muzzle, _pointer, _optic, +_primaryMagazine, +_secondaryMagazine, _bipod]
