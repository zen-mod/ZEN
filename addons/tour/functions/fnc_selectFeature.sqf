#include "script_component.hpp"
/*
 * Author: mharis001
 * Selects the given feature in the sidebar, rendering its page.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Feature <CONFIG>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY, _feature] call zen_tour_fnc_selectFeature
 *
 * Public: No
 */

params ["_display", "_feature"];

// Highlight the selected entry in the sidebar
private _entries = _display getVariable QGVAR(entries);

{
    private _isSelected = _x isEqualTo _feature;

    private _backgroundAlpha = [0, 0.08] select _isSelected;
    private _ctrlBackground = _y controlsGroupCtrl IDC_ENTRY_BACKGROUND;
    _ctrlBackground ctrlSetBackgroundColor [1, 1, 1, _backgroundAlpha];

    private _titleAlpha = [0.7, 1] select _isSelected;
    private _ctrlTitle = _y controlsGroupCtrl IDC_ENTRY_TITLE;
    _ctrlTitle ctrlSetTextColor [1, 1, 1, _titleAlpha];

    private _ctrlAccent = _y controlsGroupCtrl IDC_ENTRY_ACCENT;
    _ctrlAccent ctrlShow _isSelected;
} forEach _entries;

// The sidebar can be rebuilt while keeping the same feature selected
private _currentFeature = _display getVariable [QGVAR(feature), configNull];
if (_feature isEqualTo _currentFeature) exitWith {};

_display setVariable [QGVAR(feature), _feature];
[_display, _feature] call FUNC(renderPage);
