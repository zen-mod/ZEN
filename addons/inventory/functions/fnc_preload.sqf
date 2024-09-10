#include "script_component.hpp"
/*
 * Author: Dedmen, Alganthe
 * Compiles a list of all compatible items for the inventory display.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_inventory_fnc_preload
 *
 * Public: No
 */

private _itemsList = [
    [], // 0  - Primary
    [], // 1  - Secondary
    [], // 2  - Handgun
    [], // 3  - Optic
    [], // 4  - Side
    [], // 5  - Muzzle
    [], // 6  - Bipod
    [], // 7  - Magazines
    [], // 8  - Headgear
    [], // 9  - Uniforms
    [], // 10 - Vests
    [], // 11 - Backpacks
    [], // 12 - Goggles
    [], // 13 - NVGs
    [], // 14 - Binoculars
    [], // 15 - Map
    [], // 16 - Compass
    [], // 17 - Radio
    [], // 18 - Watch
    [], // 19 - Comms
    [], // 20 - Throw
    [], // 21 - Put
    []  // 22 - Inventory Items
];

private _cfgWeapons = configFile >> "CfgWeapons";

{
    if (getNumber (_x >> "scope") == 2) then {
        private _configName = configName _x;
        private _itemType = getNumber (_x >> "ItemInfo" >> "type");
        private _simulation = getText (_x >> "simulation");

        switch (true) do {
            case (_itemType in [TYPE_OPTICS, TYPE_FLASHLIGHT, TYPE_MUZZLE, TYPE_BIPOD] && {!(_configName isKindOf ["CBA_MiscItem", _cfgWeapons])}): {
                private _index = 3 + ([TYPE_OPTICS, TYPE_FLASHLIGHT, TYPE_MUZZLE, TYPE_BIPOD] find _itemType);
                _itemsList select _index pushBackUnique _configName;
            };
            case (_itemType == TYPE_HEADGEAR): {
                _itemsList select ITEMS_HEADGEAR pushBackUnique _configName;
            };
            case (_itemType == TYPE_UNIFORM): {
                _itemsList select ITEMS_UNIFORMS pushBackUnique _configName;
            };
            case (_itemType == TYPE_VEST): {
                _itemsList select ITEMS_VESTS pushBackUnique _configName;
            };
            case (_simulation == "NVGoggles"): {
                _itemsList select ITEMS_NVGS pushBackUnique _configName;
            };
            case (_simulation == "Binocular" || {_simulation == "Weapon" && {getNumber (_x >> "type") == TYPE_BINOCULAR_AND_NVG}}): {
                _itemsList select ITEMS_BINOCULARS pushBackUnique _configName;
            };
            case (_simulation == "ItemMap"): {
                _itemsList select ITEMS_MAP pushBackUnique _configName;
            };
            case (_simulation == "ItemCompass"): {
                _itemsList select ITEMS_COMPASS pushBackUnique _configName;
            };
            case (_simulation == "ItemRadio"): {
                _itemsList select ITEMS_RADIO pushBackUnique _configName;
            };
            case (_simulation == "ItemWatch"): {
                _itemsList select ITEMS_WATCH pushBackUnique _configName;
            };
            case (_simulation == "ItemGPS" || {_itemType == TYPE_UAV_TERMINAL}): {
                _itemsList select ITEMS_COMMS pushBackUnique _configName;
            };
            case (isClass (_x >> "WeaponSlotsInfo") && {getNumber (_x >> "type") != TYPE_BINOCULAR_AND_NVG}): {
                switch (getNumber (_x >> "type")) do {
                    case TYPE_WEAPON_PRIMARY: {
                        _itemsList select ITEMS_PRIMARY pushBackUnique (_configName call BIS_fnc_baseWeapon);
                    };
                    case TYPE_WEAPON_SECONDARY: {
                        _itemsList select ITEMS_SECONDARY pushBackUnique (_configName call BIS_fnc_baseWeapon);
                    };
                    case TYPE_WEAPON_HANDGUN: {
                        _itemsList select ITEMS_HANDGUN pushBackUnique (_configName call BIS_fnc_baseWeapon);
                    };
                };
            };
            case (_itemType in [TYPE_MUZZLE, TYPE_OPTICS, TYPE_FLASHLIGHT, TYPE_BIPOD] && {_configName isKindOf ["CBA_MiscItem", _cfgWeapons]});
            case (_itemType in [TYPE_FIRST_AID_KIT, TYPE_MEDIKIT, TYPE_TOOLKIT] || {_simulation == "ItemMineDetector"}): {
                _itemsList select ITEMS_MISC pushBackUnique _configName;
            };
        };
    };
} forEach configProperties [_cfgWeapons, "isClass _x"];

private _grenadeList = [];

{
    _grenadeList append getArray (_cfgWeapons >> "Throw" >> _x >> "magazines");
} forEach getArray (_cfgWeapons >> "Throw" >> "muzzles");

private _putList = [];

{
    _putList append getArray (_cfgWeapons >> "Put" >> _x >> "magazines");
} forEach getArray (_cfgWeapons >> "Put" >> "muzzles");

{
    if (getNumber (_x >> "scope") == 2) then {
        private _configName = configName _x;

        switch (true) do {
            case (
                getNumber (_x >> "type") in [TYPE_MAGAZINE_PRIMARY_AND_THROW, TYPE_MAGAZINE_SECONDARY_AND_PUT, 1536, TYPE_MAGAZINE_HANDGUN_AND_GL, TYPE_MAGAZINE_MISSILE]
                && {!(_configName in _grenadeList)}
                && {!(_configName in _putList)}
            ): {
                _itemsList select ITEMS_MAGAZINES pushBackUnique _configName;
            };
            case (_configName in _grenadeList): {
                _itemsList select ITEMS_THROW pushBackUnique _configName;
            };
            case (_configName in _putList): {
                _itemsList select ITEMS_PUT pushBackUnique _configName;
            };
        };
    };
} forEach configProperties [configFile >> "CfgMagazines", "isClass _x"];;

{
    if (getNumber (_x >> "scope") == 2 && {getNumber (_x >> "isBackpack") == 1}) then {
        _itemsList select ITEMS_BACKPACKS pushBackUnique configName _x;
    };
} forEach configProperties [configFile >> "CfgVehicles", "isClass _x"];

{
    if (getNumber (_x >> "scope") == 2) then {
        _itemsList select ITEMS_GOGGLES pushBackUnique configName _x;
    };
} forEach configProperties [configFile >> "CfgGlasses", "isClass _x"];

uiNamespace setVariable [QGVAR(itemsList), _itemsList];
