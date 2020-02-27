#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if Zeus display is currently in placement mode.
 * User has an entity to place selected.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * In Placement Mode <BOOL>
 *
 * Example:
 * [] call zen_common_fnc_isPlacementActive
 *
 * Public: No
 */

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
if (isNull _display) exitWith {false};

RscDisplayCurator_sections params ["_mode"];

// Get the path length necessary for placement based on the current mode
private _pathLength = [3, 4, 2, 1, 1] select _mode;

count tvCurSel call FUNC(getActiveTree) == _pathLength
