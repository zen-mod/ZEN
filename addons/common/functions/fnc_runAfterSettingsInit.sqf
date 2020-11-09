#include "script_component.hpp"
/*
 * Author: PabstMirror
 * Executes the given code after settings are initialized.
 *
 * Arguments:
 * 0: Function <CODE>
 * 1: Arguments <ANY> (default: [])
 *
 * Return Value:
 * None
 *
 * Example:
 * [_function, _args] call zen_common_fnc_runAfterSettingsInit
 *
 * Public: No
 */

params [["_function", {}, [{}]], ["_args", []]];

if (GVAR(settingsInitialized)) then {
    // Settings already initialized, directly run the code
    [_function, _args] call CBA_fnc_directCall;
} else {
    // Waiting for settings to be initialized, add to delayed code array
    GVAR(runAfterSettingsInit) pushBack [_function, _args];
};
