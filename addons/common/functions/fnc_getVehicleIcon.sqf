#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the file path of the given object's vehicle icon.
 *
 * Arguments:
 * 0: Object or Object Type <OBJECT|STRING>
 *
 * Return Value:
 * Icon File Path <STRING>
 *
 * Example:
 * ["B_MRAP_01_F"] call zen_common_fnc_getVehicleIcon
 *
 * Public: No
 */

#define DEFAULT_ICON "\a3\ui_f\data\map\vehicleicons\iconvehicle_ca.paa"

params [["_object", "", ["", objNull]]];

if (isNil QGVAR(vehicleIcons)) then {
    GVAR(vehicleIcons) = createHashMap;
};

private _objectType = if (_object isEqualType objNull) then {
    typeOf _object
} else {
    // Normalize cache key to config case
    configName (configFile >> "CfgVehicles" >> _object)
};

GVAR(vehicleIcons) getOrDefaultCall [_objectType, {
    private _icon = getText (configFile >> "CfgVehicles" >> _objectType >> "icon");

    if (isText (configFile >> "CfgVehicleIcons" >> _icon)) then {
        _icon = getText (configFile >> "CfgVehicleIcons" >> _icon);
    };

    if (
        !fileExists _icon
        // Allow procedural textures
        && {_icon select [0, 1] != "#"}
    ) then {
        // Sometimes the config defines the texture without file extension
        // fileExists returns false even though this is a valid config
        _icon = _icon + ".paa";

        if (fileExists _icon) exitWith {
            _icon
        };

        DEFAULT_ICON
    } else {
        _icon
    };
}, true]
