#include "script_component.hpp"
/*
 * Author: mharis001
 * Registers a custom module to be available in the Zeus modules tree.
 * Function is executed in an unscheduled environment where module is placed.
 *
 * Passed parameters:
 *   0: Module Position ASL <ARRAY>
 *   1: Attached Object (objNull if not attached) <OBJECT>
 *
 * Arguments:
 * 0: Category <STRING>
 * 1: Name <STRING>
 * 2: Function <CODE>
 * 3: Icon <STRING> (default: "\a3\modules_f\data\portraitmodule_ca.paa")
 *
 * Return Value:
 * Registered <BOOL>
 *
 * Example:
 * ["Custom Modules", "Cool Hint", {hint str _this}] call zen_custom_modules_fnc_register
 *
 * Public: Yes
 */

if (canSuspend) exitWith {
    [FUNC(register), _this] call CBA_fnc_directCall;
};

params [
    ["_category", "", [""]],
    ["_displayName", "", [""]],
    ["_function", {}, [{}]],
    ["_icon", "", [""]],
    ["_persist", false, [false]]
];

if (isNil QGVAR(modulesList)) then {
    GVAR(modulesList) = [];
};

if (count GVAR(modulesList) >= 100) exitWith {
    WARNING("Maximum amount of custom modules reached!");
    false
};

if (isLocalized _category) then {
    _category = localize _category;
};

if (isLocalized _displayName) then {
    _displayName = localize _displayName;
};

if (_icon isEqualTo "") then {
    _icon = DEFAULT_ICON;
};

GVAR(modulesList) pushBack [_category, _displayName, _icon, _function, _persist];

true
