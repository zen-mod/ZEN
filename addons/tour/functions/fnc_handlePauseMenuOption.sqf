#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles clicking the pause menu option.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call zen_tour_fnc_handlePauseMenuOption
 *
 * Public: No
 */

// The tour is opened once the pause menu is gone, since a dialog created while
// it is open appears underneath it
findDisplay IDD_INTERRUPT closeDisplay IDC_CANCEL;
[FUNC(open)] call CBA_fnc_execNextFrame;
