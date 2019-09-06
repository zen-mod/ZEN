#include "script_component.hpp"
/*
 * Author: mharis001
 * Calculates the total mass of all items in the inventory attribute.
 * Properly handles sub-configs and CfgGlasses entries.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * Load <NUMBER>
 *
 * Example:
 * [DISPLAY] call zen_inventory_fnc_calculateLoad
 *
 * Public: No
 */

params ["_controlsGroup"];

private _cargo = +(_controlsGroup getVariable QEGVAR(attributes,value));
_cargo params ["_itemCargo", "_weaponCargo", "_magazineCargo", "_backpackCargo"];

private _load = 0;

private _fnc_addMasses = {
    params ["_cargoList", "_baseConfig", "_subConfig"];
    _cargoList params ["_cargoItems", "_cargoCounts"];

    {
        private _config = _baseConfig >> _x;

        if (!isNil "_subConfig") then {
            _config = _config >> _subConfig;
        };

        _load = _load + getNumber (_config >> "mass") * (_cargoCounts select _forEachIndex);
    } forEach _cargoItems;
};

// Special handling for facewear in item cargo, separate out CfgGlasses entries
private _glassesCargo = [[], []];
_glassesCargo params ["_glassesItems", "_glassesCounts"];

private _cfgGlasses = configFile >> "CfgGlasses";
_itemCargo params ["_itemCargoItems", "_itemCargoCounts"];

{
    if (isClass (_cfgGlasses >> _x)) then {
        _glassesItems  pushBack (_itemCargoItems  deleteAt _forEachIndex);
        _glassesCounts pushBack (_itemCargoCounts deleteAt _forEachIndex);
    };
} forEach _itemCargoItems;

[_itemCargo,     configFile >> "CfgWeapons", "ItemInfo"] call _fnc_addMasses;
[_weaponCargo,   configFile >> "CfgWeapons", "WeaponSlotsInfo"] call _fnc_addMasses;
[_magazineCargo, configFile >> "CfgMagazines"] call _fnc_addMasses;
[_backpackCargo, configFile >> "CfgVehicles"] call _fnc_addMasses;
[_glassesCargo, _cfgGlasses] call _fnc_addMasses;

_controlsGroup setVariable [QGVAR(currentLoad), _load];

_load
