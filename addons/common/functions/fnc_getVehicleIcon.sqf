#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns the file path of the given vehicle's icon.
 *
 * Arguments:
 * 0: Vehicle <STRING|OBJECT>
 *
 * Return Value:
 * Icon File Path <STRING>
 *
 * Example:
 * ["B_MRAP_01_F"] call zen_common_fnc_getVehicleIcon
 *
 * Public: No
 */

params [["_vehicle", "", ["", objNull]]];

if (isNil QGVAR(vehicleIcons)) then {
    GVAR(vehicleIcons) = [] call CBA_fnc_createNamespace;
};

if (_vehicle isEqualType objNull) then {
    _vehicle = typeOf _vehicle;
};

private _icon = GVAR(vehicleIcons) getVariable _vehicle;

if (isNil "_icon") then {
    _icon = getText (configFile >> "CfgVehicles" >> _vehicle >> "icon");

    if (isText (configFile >> "CfgVehicleIcons" >> _icon)) then {
        _icon = getText (configFile >> "CfgVehicleIcons" >> _icon);
    };

    GVAR(vehicleIcons) setVariable [_vehicle, _icon];
};

_icon
