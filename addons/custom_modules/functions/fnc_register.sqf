#include "script_component.hpp"
/*
 * Author: mharis001
 * Registers a custom module to be available in the Zeus modules tree.
 * Function is executed in an unscheduled environment on the machine where the module is placed.
 *
 * Passed Parameters:
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
    ["_name", "", [""]],
    ["_function", {}, [{}]],
    ["_icon", "", [""]]
];

if (isNil QGVAR(list)) then {
    GVAR(list) = [];
};

if (count GVAR(list) >= 200) exitWith {
    WARNING("Maximum amount of custom modules reached!");
    false
};

if (isLocalized _category) then {
    _category = localize _category;
};

if (isLocalized _name) then {
    _name = localize _name;
};

if (_icon == "") then {
    _icon = ICON_DEFAULT;
};

GVAR(list) pushBack [_category, _name, _icon, _function];

// Reload the display so the module is added to the tree
[] call EFUNC(common,reloadDisplay);

true
