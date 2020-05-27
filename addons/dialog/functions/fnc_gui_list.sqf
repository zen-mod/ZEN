#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the LIST content control.
 *
 * Arguments:
 * 0: Controls Group <CONTROL>
 * 1: Default Value <ANY>
 * 2: Settings <ARRAY>
 *   0: Entries <ARRAY>
 *     N: [Value <ANY>, Text <STRING>, Tooltip <STRING>, Picture <STRING>, Text Color <ARRAY>] <ARRAY>
 *   1: Height <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, [_entries, _height]] call zen_dialog_fnc_gui_list
 *
 * Public: No
 */

params ["_controlsGroup", "_defaultValue", "_settings"];
_settings params ["_entries", "_height"];

// Adjust height of list based on settings
private _ctrlList = _controlsGroup controlsGroupCtrl IDC_ROW_COMBO;
_ctrlList ctrlSetPositionH POS_H(_height);
_ctrlList ctrlCommit 0;

_controlsGroup ctrlSetPositionH POS_H(_height + 1);
_controlsGroup ctrlCommit 0;

// Use initialization function for COMBO control to add entries, handling is identical
[_controlsGroup, _defaultValue, [_entries]] call FUNC(gui_combo);
