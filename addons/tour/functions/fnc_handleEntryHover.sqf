#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles the mouse entering or exiting a sidebar entry.
 *
 * Arguments:
 * 0: Mouse Area <CONTROL>
 * 1: Hovered <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, true] call zen_tour_fnc_handleEntryHover
 *
 * Public: No
 */

params ["_ctrlMouse", "_isHovered"];

private _display = ctrlParent _ctrlMouse;
private _feature = _ctrlMouse getVariable QGVAR(feature);

// The selected entry keeps its own highlight
if (_feature isEqualTo (_display getVariable QGVAR(feature))) exitWith {};

private _ctrlEntry = ctrlParentControlsGroup _ctrlMouse;
private _ctrlBackground = _ctrlEntry controlsGroupCtrl IDC_ENTRY_BACKGROUND;
private _alpha = [0, 0.04] select _isHovered;
_ctrlBackground ctrlSetBackgroundColor [1, 1, 1, _alpha];
