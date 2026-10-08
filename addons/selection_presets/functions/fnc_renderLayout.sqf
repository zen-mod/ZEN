#include "script_component.hpp"
/*
 * Author: mharis001
 * Renders the selection presets bar's layout.
 *
 * Arguments:
 * 0: Preset Bar Control <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_selection_presets_fnc_renderLayout
 *
 * Public: No
 */

BEGIN_COUNTER(renderLayout);

params ["_ctrlPresets"];

private _presets = [] call FUNC(get);

// Determine the visible slots
private _showAll = GVAR(emptySlotMode) == EMPTY_SLOT_MODE_SHOW_ALL;
private _visibleSlots = _presets apply {_showAll || {_x isNotEqualTo []}};
private _visibleSlotsCount = {_x} count _visibleSlots;

// Show the add preset button if needed and there is at least one hidden slot
private _showAddButton = (
    GVAR(emptySlotMode) == EMPTY_SLOT_MODE_REPLACE_WITH_ADD_BUTTON
    && {false in _visibleSlots}
);

// Layout candidates are in preference order, representing the following:
// - Layout identifier
// - Slot width
// - Slot height
// - Add button width
private _layouts = [
    [SLOT_LAYOUT_WIDE,    POS_W(5),   POS_H(1.2), POS_W(2.5)],
    [SLOT_LAYOUT_STACKED, POS_W(4.2), POS_H(2),   POS_W(2)],
    [SLOT_LAYOUT_COMPACT, POS_W(2.2), POS_H(3),   POS_W(1.5)]
];

// Select the first layout that fits within the available width
private _availableWidth = safeZoneW - POS_W(POS_EDGE_SQF(25,22));
private _layoutIndex = _layouts findIf {
    _x params ["", "_slotWidth", "", "_addButtonWidth"];

    private _requiredWidth = _visibleSlotsCount * _slotWidth;

    if (_showAddButton) then {
        _requiredWidth = _requiredWidth + _addButtonWidth;
    };

    _requiredWidth <= _availableWidth
};

// When no layouts fit, this will select the last one (i.e., the narrowest one)
_layouts select _layoutIndex params ["_layout", "_slotWidth", "_slotHeight", "_addButtonWidth"];

// Center the bar between the side panels
private _extraWidth = [0, _addButtonWidth] select _showAddButton;
private _barWidth = _visibleSlotsCount * _slotWidth + _extraWidth;
private _leftEdge = safeZoneX + POS_W(POS_EDGE_SQF(12.5,11));
private _remainingWidth = _availableWidth - _barWidth;
private _barX = _leftEdge + _remainingWidth / 2;
private _barY = safeZoneY + safeZoneH - _slotHeight;
private _barPosition = [_barX, _barY, _barWidth, _slotHeight];

// Skip updates when the layout, visibility, and pixel dimensions are unchanged
private _layoutState = [_layout, _visibleSlots, _showAddButton, _barPosition, pixelW, pixelH];
private _previousLayoutState = _ctrlPresets getVariable [QGVAR(layoutState), []];

if (_layoutState isEqualTo _previousLayoutState) exitWith {
    END_COUNTER(renderLayout);
};

_ctrlPresets setVariable [QGVAR(layoutState), _layoutState];

// Hide the bar when no slots or the add button need to be shown
private _isBarHidden = _barWidth == 0;

if (_isBarHidden) exitWith {
    _ctrlPresets ctrlShow false;
    END_COUNTER(renderLayout);
};

// Show the parent before restoring child visibility, since showing a group reveals its children
_ctrlPresets ctrlShow true;
_ctrlPresets ctrlSetPosition _barPosition;
_ctrlPresets ctrlCommit 0;

// Inset the frame slightly to prevent clipping at the control boundaries
private _ctrlPresetsFrame = _ctrlPresets controlsGroupCtrl IDC_PRESETS_FRAME;
_ctrlPresetsFrame ctrlSetPosition [pixelW, pixelH, _barWidth - pixelW, _slotHeight - pixelH];
_ctrlPresetsFrame ctrlCommit 0;

// Compare with the previous layout to determine which slots need to be refreshed
_previousLayoutState params [["_previousLayout", ""], ["_previousVisibleSlots", []]];
private _layoutChanged = _layout isNotEqualTo _previousLayout;
private _renderQueue = _ctrlPresets getVariable [QGVAR(renderQueue), []];

// Position the visible slots in preset-key order without leaving gaps for hidden slots
private _slotControls = _ctrlPresets getVariable [QGVAR(slots), createHashMap];
private _visibleIndex = 0;

{
    private _key = PRESET_KEYS select _forEachIndex;
    private _ctrlSlot = _slotControls get _key;
    _ctrlSlot ctrlShow _x;

    if (_x) then {
        _ctrlSlot setVariable [QGVAR(layout), _layout];
        _ctrlSlot ctrlSetPosition [_visibleIndex * _slotWidth, 0, _slotWidth, _slotHeight];
        _ctrlSlot ctrlCommit 0;

        // Refresh slots whose content layout changed or those that have just become visible
        private _wasVisible = _previousVisibleSlots param [_forEachIndex, false];

        if (_layoutChanged || {!_wasVisible}) then {
            _renderQueue pushBackUnique _key;
        };

        _visibleIndex = _visibleIndex + 1;
    };
} forEach _visibleSlots;

// Position the add button after the visible slots
private _ctrlAddPreset = _ctrlPresets controlsGroupCtrl IDC_ADD_PRESET;
_ctrlAddPreset ctrlShow _showAddButton;

if (_showAddButton) then {
    _ctrlAddPreset ctrlSetPosition [
        _visibleIndex * _slotWidth,
        0,
        _addButtonWidth,
        _slotHeight
    ];
    _ctrlAddPreset ctrlCommit 0;

    {
        private _ctrl = _ctrlAddPreset controlsGroupCtrl _x;

        // The divider is different and should only be one pixel wide
        private _width = [_addButtonWidth, pixelW] select (_x == IDC_ADD_PRESET_DIVIDER);
        _ctrl ctrlSetPosition [0, 0, _width, _slotHeight];
        _ctrl ctrlCommit 0;
    } forEach [
        IDC_ADD_PRESET_BACKGROUND,
        IDC_ADD_PRESET_DIVIDER,
        IDC_ADD_PRESET_MOUSE
    ];

    // Position the plus icon in the center of the button
    private _ctrlAddPresetPlus = _ctrlAddPreset controlsGroupCtrl IDC_ADD_PRESET_PLUS;
    _ctrlAddPresetPlus ctrlSetPosition [
        (_addButtonWidth - POS_W(PLUS_ICON_SIZE)) / 2,
        (_slotHeight - POS_H(PLUS_ICON_SIZE)) / 2,
        POS_W(PLUS_ICON_SIZE),
        POS_H(PLUS_ICON_SIZE)
    ];
    _ctrlAddPresetPlus ctrlCommit 0;
};

END_COUNTER(renderLayout);
