#include "script_component.hpp"
/*
 * Author: 654wak654
 * Shows the given Zeus feedback message.
 * Handles localization and formatting multiple arguments.
 *
 * Arguments:
 * 0: Message <STRING>
 * N: Anything <ANY> (default: nil)
 *
 * Return Value:
 * None
 *
 * Example:
 * ["Message: %1", _hint] call zen_common_fnc_showMessage
 *
 * Public: Yes
 */

if !(_this isEqualTypeParams [""]) exitWith {
    ERROR_1("First argument must be a string - %1.",_this);
};

private _message = _this apply {if (_x isEqualType "" && {isLocalized _x}) then {localize _x} else {_x}};
[objNull, format _message] call BIS_fnc_showCuratorFeedbackMessage;
