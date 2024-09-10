#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the default config defined inventory of the given object.
 *
 * Arguments:
 * 0: Object <STRING|OBJECT>
 *
 * Return Value:
 * Default Inventory <ARRAY>
 *
 * Example:
 * [_object] call zen_common_fnc_getDefaultInventory
 *
 * Public: No
 */

params [["_object", "", ["", objNull]]];

if (isNil QGVAR(defaultInventories)) then {
    GVAR(defaultInventories) = [] call CBA_fnc_createNamespace;
};

if (_object isEqualType objNull) then {
    _object = typeOf _object;
};

private _inventory = GVAR(defaultInventories) getVariable _object;

if (isNil "_inventory") then {
    private _cfgMagazines = configFile >> "CfgMagazines";
    private _cfgVehicles = configFile >> "CfgVehicles";
    private _cfgWeapons = configFile >> "CfgWeapons";

    private _fnc_addToCargoArray = {
        params ["_cargo", "_item", "_count"];
        _cargo params ["_types", "_counts"];

        private _index = _types find _item;

        if (_index == -1) then {
            _index = _types pushBack _item;
        };

        _counts set [_index, (_counts param [_index, 0]) + _count];
    };

    private _config = _cfgVehicles >> _object;

    _inventory = [[[], []], [[], []], [[], []], [[], []]];
    _inventory params ["_itemCargo", "_weaponCargo", "_magazineCargo", "_backpackCargo"];

    // Need special handling for TransportItems class
    // It can contain binoculars (or even weapons) which should go under weapon cargo not item cargo
    {
        private _item = getText (_x >> "name");
        private _count = getNumber (_x >> "count");

        private _config = _cfgWeapons >> _item;
        private _type = getNumber (_config >> "type");
        private _simulation = getText (_config >> "simulation");

        // Ensure config case, item could be a CfgGlasses class
        _item = configName (_item call CBA_fnc_getItemConfig);

        if (
            _type in [TYPE_WEAPON_PRIMARY, TYPE_WEAPON_SECONDARY, TYPE_WEAPON_HANDGUN]
            || {_simulation == "Binocular" || {_simulation == "Weapon" && {_type == TYPE_BINOCULAR_AND_NVG}}}
        ) then {
            [_weaponCargo, _item, _count] call _fnc_addToCargoArray;
        } else {
            [_itemCargo, _item, _count] call _fnc_addToCargoArray;
        };
    } forEach configProperties [_config >> "TransportItems", "isClass _x"];

    {
        private _weapon = configName (_cfgWeapons >> getText (_x >> "weapon"));
        private _count = getNumber (_x >> "count");

        [_weaponCargo, _weapon, _count] call _fnc_addToCargoArray;
    } forEach configProperties [_config >> "TransportWeapons", "isClass _x"];

    {
        private _magazine = configName (_cfgMagazines >> getText (_x >> "magazine"));
        private _count = getNumber (_x >> "count");

        [_magazineCargo, _magazine, _count] call _fnc_addToCargoArray;
    } forEach configProperties [_config >> "TransportMagazines", "isClass _x"];

    {
        private _backpack = configName (_cfgVehicles >> getText (_x >> "backpack"));
        private _count = getNumber (_x >> "count");

        [_backpackCargo, _backpack, _count] call _fnc_addToCargoArray;
    } forEach configProperties [_config >> "TransportBackpacks", "isClass _x"];

    GVAR(defaultInventories) setVariable [_object, _inventory];
};

+_inventory
