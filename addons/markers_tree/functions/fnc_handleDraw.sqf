#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles drawing area markers on the map to indicate placement.
 *
 * Arguments:
 * 0: Map <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_markers_tree_fnc_handleDraw
 *
 * Public: No
 */

BEGIN_COUNTER(draw);

params ["_ctrlMap"];

private _display = ctrlParent _ctrlMap;
private _ctrlTreeAreas = _display displayCtrl IDC_MARKERS_TREE_AREAS;
private _shape = _ctrlTreeAreas tvData tvCurSel _ctrlTreeAreas;

if (ctrlShown _ctrlTreeAreas && {_shape != ""} && EFUNC(common,isCursorOnMouseArea)) then {
    private _position = _ctrlMap ctrlMapScreenToWorld getMousePosition;
    private _drawArgs = [_position, 50, 50, 0, [0, 0, 0, 0.7], "#(rgb,8,8,3)color(0,0,0,0.7)"];

    switch (_shape) do {
        case "ELLIPSE": {
            _ctrlMap drawEllipse _drawArgs;
        };
        case "RECTANGLE": {
            _ctrlMap drawRectangle _drawArgs;
        };
    };
};

END_COUNTER(draw);
