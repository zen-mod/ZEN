#include "script_component.hpp"
/*
 * Author: Ampersand
 * Saves curator selected entities for use by modules.
 *
 * Arguments:
 * 0: Curator <OBJECT>
 * 0: Entity: group, marker, object, or waypoint <GROUP, STRING, OBJECT, ARRAY>
 *
 * Return Value:
 * Handled <BOOL>
 *
 * Example:
 * [CONTROL] call zen_editor_fnc_handleSelectionChanged
 *
 * Public: No
 */

params ["_curator", "_entity"];
GVAR(savedSelection) = GVAR(lastSelection);
GVAR(lastSelection) = curatorSelected;

false
