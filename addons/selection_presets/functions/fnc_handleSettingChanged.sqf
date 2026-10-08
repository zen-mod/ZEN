#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles changing a CBA setting.
 *
 * Arguments:
 * 0: Setting <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_setting] call zen_selection_presets_fnc_handleSettingChanged
 *
 * Public: No
 */

params ["_setting"];

private _display = findDisplay IDD_RSCDISPLAYCURATOR;
if (isNull _display) exitWith {};

if (_setting == QGVAR(enabled)) exitWith {
    if (GVAR(enabled)) then {
        [_display] call FUNC(createBar);

        // Selection may already match a preset when enabling
        [] call FUNC(handleObjectSelectionChanged);
    } else {
        [_display] call FUNC(deleteBar);
    };
};

private _ctrlPresets = _display displayCtrl IDC_PRESETS;
if (isNull _ctrlPresets) exitWith {};

// These settings affect slot contents without changing the bar's layout
if (_setting in [QGVAR(useGroupIcons), QGVAR(showTooltips)]) exitWith {
    [nil, false] call FUNC(queueRender);
};

// Need to recalculate slot visibility or available width when these settings change
if (_setting in [QGVAR(emptySlotMode), QEGVAR(editor,moveDisplayToEdge)]) exitWith {
    _ctrlPresets setVariable [QGVAR(layoutDirty), true];
};
