#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the Zeus display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_editor_previews_fnc_initDisplayCurator
 *
 * Public: No
 */

if (!GVAR(enabled)) exitWith {};

params ["_display"];

// Disable pixel rounding to fix inconsistent border size for images with different aspect ratios
private _ctrlGroup = _display ctrlCreate [QGVAR(control), IDC_PREVIEW_GROUP];
_ctrlGroup ctrlSetPixelPrecision 2;
_ctrlGroup ctrlShow false;

private _ctrlImage = _display displayCtrl IDC_PREVIEW_IMAGE;
_ctrlImage ctrlSetPixelPrecision 2;

{
    private _ctrlTree = _display displayCtrl _x;
    _ctrlTree ctrlAddEventHandler ["TreeMouseMove", {call FUNC(handleMouseUpdate)}];
    _ctrlTree ctrlAddEventHandler ["TreeMouseHold", {call FUNC(handleMouseUpdate)}];
    _ctrlTree ctrlAddEventHandler ["TreeMouseExit", {call FUNC(handleMouseExit)}];
} forEach [
    IDC_RSCDISPLAYCURATOR_CREATE_UNITS_WEST,
    IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EAST,
    IDC_RSCDISPLAYCURATOR_CREATE_UNITS_GUER,
    IDC_RSCDISPLAYCURATOR_CREATE_UNITS_CIV,
    IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY
];
