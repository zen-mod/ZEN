#include "script_component.hpp"
/*
 * Author: mharis001
 * Opens the feature catalog, or the new features from the given releases.
 *
 * Arguments:
 * 0: Releases <ARRAY> (default: [])
 *   - Shows "What's New" for these releases when given, otherwise all features.
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_tour_fnc_open
 *
 * Public: No
 */

params [["_releases", [], [[]]]];

// Opened as a dialog to block input, such as scrolling, that would otherwise reach the Zeus display
if (!createDialog QGVAR(display)) exitWith {};

private _display = uiNamespace getVariable QGVAR(display);
[_display, _releases] call FUNC(renderSidebar);

private _feature = _display getVariable QGVAR(features) select 0;
[_display, _feature] call FUNC(selectFeature);
