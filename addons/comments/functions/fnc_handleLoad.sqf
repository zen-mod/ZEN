#include "script_component.hpp"
/*
 * Author: Timi007
 * Handles initializing the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_comments_fnc_handleLoad
 *
 * Public: No
 */

params ["_display"];

// The container blocks mouse events in the world or on the map unless it is disabled
private _ctrlContainer = _display displayCtrl IDC_CONTAINER;
_ctrlContainer ctrlEnable false;

_display displayAddEventHandler ["KeyDown", {call FUNC(handleKeyDown)}];

{
    {
        [_x] call FUNC(createIcon);
    } forEach GVAR(comments);
} call CBA_fnc_execNextFrame;
