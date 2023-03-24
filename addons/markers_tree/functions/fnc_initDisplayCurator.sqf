#include "script_component.hpp"
/*
 * Author: mharis001
 * Initializes the Zeus Display.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_markers_tree_fnc_initDisplayCurator
 *
 * Public: No
 */

params ["_display"];

private _ctrlTreeEngine = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MARKERS;
_ctrlTreeEngine ctrlAddEventHandler ["TreeSelChanged", {call FUNC(handleEngineSelect)}];

private _ctrlTreeIcons = _display displayCtrl IDC_MARKERS_TREE_ICONS;
_ctrlTreeIcons ctrlAddEventHandler ["TreeSelChanged", {call FUNC(handleIconsSelect)}];
_ctrlTreeIcons call FUNC(populate);

private _ctrlTreeAreas = _display displayCtrl IDC_MARKERS_TREE_AREAS;
_ctrlTreeAreas ctrlAddEventHandler ["TreeSelChanged", {call FUNC(handleAreasSelect)}];

{
    _x params ["_text", "_icon", "_data"];

    private _index = _ctrlTreeAreas tvAdd [[], localize _text];
    _ctrlTreeAreas tvSetPicture [[_index], _icon];
    _ctrlTreeAreas tvSetData [[_index], _data];
} forEach [
    ["str_3den_attributes_shapetrigger_ellipse", "a3\3den\data\cfg3den\marker\iconellipse_ca.paa", "ELLIPSE"],
    ["str_3den_attributes_shapetrigger_rectangle", "a3\3den\data\cfg3den\marker\iconrectangle_ca.paa", "RECTANGLE"]
];

private _ctrlMap = _display displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP;
_ctrlMap ctrlAddEventHandler ["MouseButtonDown", {call FUNC(handleMouseButtonDown)}];
_ctrlMap ctrlAddEventHandler ["MouseButtonUp", {call FUNC(handleMouseButtonUp)}];
_ctrlMap ctrlAddEventHandler ["MouseMoving", {call FUNC(handleMouseMoving)}];
_ctrlMap ctrlAddEventHandler ["Draw", {call FUNC(handleDraw)}];

{
    private _ctrlMode = _display displayCtrl _x;
    _ctrlMode ctrlAddEventHandler ["ButtonClick", {call FUNC(handleSubModeClicked)}];

    // Handle initially applying the current sub-mode
    if (GVAR(mode) == _forEachIndex) then {
        _ctrlMode call FUNC(handleSubModeClicked);
    };
} forEach [IDC_MARKERS_MODE_ICONS, IDC_MARKERS_MODE_AREAS];

// Handle initially hiding/showing the custom marker trees
missionNamespace getVariable ["RscDisplayCurator_sections", [0, 0]] params ["_mode"];
[_display, _mode] call FUNC(handleTreeChange);

// Need frame delay workaround for usage of ctrlActivate by RscDisplayCurator.sqf
// to properly hide the empty side control when initially in markers mode
if (_mode == 3) then {
    private _ctrlSideEmpty = _display displayCtrl IDC_RSCDISPLAYCURATOR_SIDEEMPTY;

    [{
        [{
            [{
                _this ctrlShow false;
            }, _this] call CBA_fnc_execNextFrame;
        }, _this] call CBA_fnc_execNextFrame;
    }, _ctrlSideEmpty] call CBA_fnc_execNextFrame;
};
