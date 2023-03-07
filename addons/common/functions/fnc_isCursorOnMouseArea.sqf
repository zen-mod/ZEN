#include "script_component.hpp"
/*
 * Author: mharis001
 * Checks if the Zeus display's cursor is currently hovering over
 * the mouse area (or the map) without any other overlapping controls
 * such as the create or edit trees.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * On Mouse Area <BOOL>
 *
 * Example:
 * [] call zen_common_fnc_isCursorOnMouseArea
 *
 * Public: No
 */

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
private _ctrlIDC = ctrlIDC (_display ctrlAt getMousePosition);
_ctrlIDC in [IDC_RSCDISPLAYCURATOR_MOUSEAREA, IDC_RSCDISPLAYCURATOR_MAINMAP]
