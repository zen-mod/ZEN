#include "script_component.hpp"
/*
 * Authors: Timi007
 * Handles the mouse button event when user wants to add a plot in 3D or on the map.
 *
 * Arguments:
 * 0: Display or control the EH is attached to <DISPLAY or CONTROL>
 * 1: Mouse button pressen <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_display, 1] call zen_plotting_fnc_onMouseButtonDown
 *
 * Public: No
 */

params ["_displayOrControl", "_button"];

if (GVAR(activePlot) isEqualTo [] || {_button != 0}) exitWith {};
TRACE_1("onMouseButtonDown",_this);

if (call EFUNC(common,isCursorOnMouseArea)) then {
    curatorMouseOver params ["_type", "_object"];

    private _endPosOrObj = switch (true) do {
        case (_type isEqualTo "OBJECT"): {_object};
        case (visibleMap): {
            private _ctrlMap = if (_displayOrControl isEqualType controlNull) then {
                _displayOrControl
            } else {
                _displayOrControl displayCtrl IDC_RSCDISPLAYCURATOR_MAINMAP
            };

            private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
            _pos2D set [2, getTerrainHeightASL _pos2D];
            _pos2D
        };
        default {[EGVAR(common,mousePos), 2] call EFUNC(common,getPosFromScreen)};
    };

    GVAR(activePlot) params ["_type", "_startPosOrObj"];

    // Add current active plot to permanent ones
    TRACE_4("Add plot",_type,_startPosOrObj,_endPosOrObj,_this);
    [QGVAR(plotAdded), [_type, _startPosOrObj, _endPosOrObj]] call CBA_fnc_localEvent;
};

GVAR(activePlot) = [];
