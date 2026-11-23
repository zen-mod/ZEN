#include "script_component.hpp"
/*
 * Author: Brett
 * Returns the total mass of the given weapon, including its attachments and loaded magazines.
 *
 * Arguments:
 * 0: Weapon Items <ARRAY>
 *
 * Return Value:
 * Mass <NUMBER>
 *
 * Example:
 * [["arifle_MX_F", "", "", "optic_Aco", ["30Rnd_65x39_caseless_mag", 30], [], ""]] call zen_inventory_fnc_getWeaponMass
 *
 * Public: No
 */

params ["_weapon"];
_weapon params ["_class", "_muzzle", "_pointer", "_optic", "_primaryMagazine", "_secondaryMagazine", "_bipod"];

private _cfgMagazines = configFile >> "CfgMagazines";
private _cfgWeapons   = configFile >> "CfgWeapons";

private _mass = getNumber (_cfgWeapons >> _class >> "WeaponSlotsInfo" >> "mass");

{
    if (_x != "") then {
        _mass = _mass + getNumber (_cfgWeapons >> _x >> "ItemInfo" >> "mass");
    };
} forEach [_muzzle, _pointer, _optic, _bipod];

{
    _x params [["_magazine", ""]];

    if (_magazine != "") then {
        _mass = _mass + getNumber (_cfgMagazines >> _magazine >> "mass");
    };
} forEach [_primaryMagazine, _secondaryMagazine];

_mass
