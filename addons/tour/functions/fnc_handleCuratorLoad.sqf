#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles initializing the Zeus display.
 * Opens a "What's New" tour for releases that have not been seen yet.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_tour_fnc_handleCuratorLoad
 *
 * Public: No
 */

if (!GVAR(enabled)) exitWith {};

params ["_display"];

// Without a last seen version, the player is new or updating from a version without the tour,
// in which case only the newest release is shown
private _lastSeen = profileNamespace getVariable [QGVAR(lastSeen), ""];
private _unseenReleases = [_lastSeen] call FUNC(getReleases);

if (_lastSeen == "") then {
    _unseenReleases = _unseenReleases select [0, 1];
};

if (_unseenReleases isEqualTo []) exitWith {};

private _newestVersion = getText (_unseenReleases select 0 >> "version");
profileNamespace setVariable [QGVAR(lastSeen), _newestVersion];
saveProfileNamespace;

// Allow the Zeus display to finish loading before covering it
[{
    params ["_display", "_unseenReleases"];

    if (isNull _display) exitWith {};

    [_unseenReleases] call FUNC(open);
}, [_display, _unseenReleases], 3] call CBA_fnc_execAfterNFrames;
