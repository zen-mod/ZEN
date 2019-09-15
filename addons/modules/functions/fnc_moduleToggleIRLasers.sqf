#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to toggle the IR lasers of infantry units.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleToggleIRLasers
 *
 * Public: No
 */

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

private _isAttached = !isNull _unit;

if (_isAttached && {!(_unit isKindOf "CAManBase")}) exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if (_isAttached && {!alive _unit}) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

private _targets = [
    [-1, west, east, independent, civilian],
    [
        [ELSTRING(common,SelectedGroup), "", ICON_GROUP],
        ["STR_West", "", ICON_BLUFOR],
        ["STR_East", "", ICON_OPFOR],
        ["STR_Guerrila", "", ICON_INDEPENDENT],
        ["STR_Civilian", "", ICON_CIVILIAN]
    ]
];

// Remove selected group option if not attached to a unit
if (!_isAttached) then {
    _targets select 0 deleteAt 0;
    _targets select 1 deleteAt 0;
};

[LSTRING(ModuleToggleIRLasers), [
    ["COMBO", [LSTRING(ToggleTarget), LSTRING(ToggleTarget_Tooltip)], _targets],
    ["TOOLBOX:ENABLED", LSTRING(ModuleToggleIRLasers_IRLasers), false],
    ["TOOLBOX:YESNO", LSTRING(AddGear), false]
], {
    params ["_values", "_group"];
    _values params ["_target", "_enabled", "_addGear"];

    // Get units based on target selection
    private _units = if (_target isEqualType west) then {
        allUnits select {alive _x && {side group _x == _target} && {!isPlayer _x}}
    } else {
        units _group
    };

    if (_enabled) then {
        private _cfgWeapons = configFile >> "CfgWeapons";

        {
            private _weapon  = currentWeapon _x;
            private _pointer = _x weaponAccessories _weapon select 1;

            // Add gear to the unit if enabled and the unit does not already have an IR laser
            if (_addGear && {_weapon != ""} && {_pointer == "" || {getNumber (_cfgWeapons >> _pointer >> "ItemInfo" >> "Pointer" >> "irDistance") <= 0}}) then {
                // Get all compatible IR laser items for the unit's weapon
                private _irLasers = [_weapon, "pointer"] call CBA_fnc_compatibleItems select {
                    getNumber (_cfgWeapons >> _x >> "ItemInfo" >> "Pointer" >> "irDistance") > 0
                };

                // Exit if the unit's weapon has no compatible IR laser items
                if (_irLasers isEqualTo []) exitwith {};

                // Add a random IR laser to the unit's weapon
                [QEGVAR(common,addWeaponItem), [_x, _weapon, selectRandom _irLasers], _x] call CBA_fnc_targetEvent;
            };

            [QEGVAR(common,enableIRLasers), [_x, _enabled], _x] call CBA_fnc_targetEvent;
        } forEach _units;
    } else {
        {
            [QEGVAR(common,enableIRLasers), [_x, _enabled], _x] call CBA_fnc_targetEvent;
        } forEach _units;
    };
}, {}, group _unit] call EFUNC(dialog,create);
