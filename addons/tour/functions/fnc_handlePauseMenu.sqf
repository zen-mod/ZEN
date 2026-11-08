#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles loading the helper display opened by the pause menu option.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_tour_fnc_handlePauseMenu
 *
 * Public: No
 */

params ["_display"];

// The tour is opened once the pause menu is gone, since a dialog created while it is open appears underneath it
_display closeDisplay IDC_CANCEL;
findDisplay IDD_INTERRUPT closeDisplay IDC_CANCEL;
[FUNC(open)] call CBA_fnc_execNextFrame;
