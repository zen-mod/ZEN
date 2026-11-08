#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking a sidebar entry, showing its feature.
 *
 * Arguments:
 * 0: Mouse Area <CONTROL>
 * 1: Button <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0] call zen_tour_fnc_handleEntryClick
 *
 * Public: No
 */

params ["_ctrlMouse", "_button"];

if (_button != 0) exitWith {};

private _display = ctrlParent _ctrlMouse;
private _feature = _ctrlMouse getVariable QGVAR(feature);

if (_feature isEqualTo (_display getVariable QGVAR(feature))) exitWith {};

playSoundUI ["SoundClick", 0.03];
[_display, _feature] call FUNC(selectFeature);
