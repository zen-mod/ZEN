#include "script_component.hpp"
/*
 * Author: mharis001
 * Registers the given attributes display type allowing attributes and buttons to be added to it.
 * The title is formatted with an entity specific description as "%1".
 * If the title is empty, a generic "Edit %1" title will be used.
 *
 * Arguments:
 * 0: Display Type <STRING>
 * 1: Title <STRING> (default: "")
 * 2: Check Entity <BOOL> (default: false)
 *
 * Return Value:
 * Successfully Registered <BOOL>
 *
 * Example:
 * ["Object", "", true] call zen_attributes_fnc_addDisplay
 *
 * Public: No
 */

params [["_displayType", "", [""]], ["_title", "", [""]], ["_checkEntity", false, [true]]];

if (!isNil {GVAR(displays) getVariable _displayType}) exitWith {
    WARNING_1("Display type (%1) already registered.",_displayType);
    false
};

if (isLocalized _title) then {
    _title = localize _title;
};

GVAR(displays) setVariable [_displayType, [_title, _checkEntity, [], []]];

true
