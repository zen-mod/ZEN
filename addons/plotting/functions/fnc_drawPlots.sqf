#include "script_component.hpp"
/*
 * Authors: Timi007
 * Draws all placed plots and currently active one in 3D or on the map. Must be called every frame.
 *
 * Arguments:
 * 0: Permanent plots in format [type, startPosASLOrObj, endPosASLOrObj] <ARRAY>
 * 1: Currently active plot in format [type, startPosASLOrObj] <ARRAY>
 * 2: Zeus map <CONTROL> (default: Draw in 3D)
 *
 * Return Value:
 * None
 *
 * Example:
 * [[["LINE", [0, 0, 0], player]], ["LINE", [100, 100, 0]]] call zen_plotting_fnc_drawPlots
 *
 * Public: No
 */

params ["_plots", ["_activePlot", [], [[]]], ["_ctrlMap", controlNull, [controlNull]]];

private _drawIn3D = isNull _ctrlMap;

private _d = 0;
private _scale = 0;
private _screenPos = [];

private _formatters = [
    (GVAR(distanceFormatters) select GVAR(currentDistanceFormatter)) select 1,
    (GVAR(speedFormatters) select GVAR(currentSpeedFormatter)) select 1,
    (GVAR(azimuthFormatters) select GVAR(currentAzimuthFormatter)) select 1
];

// Format active plot as permanent plot with mouse position as end position
private _activePlotWithMouseEndPos = [];
if (_activePlot isNotEqualTo []) then {
    _activePlot params ["_type", "_startPosOrObj"];

    private _endPos = if (_drawIn3D) then {
        [EGVAR(common,mousePos), 2] call EFUNC(common,getPosFromScreen)
    } else {
        private _pos2D = _ctrlMap ctrlMapScreenToWorld getMousePosition;
        _pos2D set [2, getTerrainHeightASL _pos2D];
        _pos2D
    };

    _activePlotWithMouseEndPos = [[_type, _startPosOrObj, _endPos]];
};

// Draw all plots
{
    _x params ["_type", "_startPosOrObj", "_endPosOrObj"];

    private _startPos = _startPosOrObj;
    if (_startPosOrObj isEqualType objNull) then {
        if (isNull _startPosOrObj) then {continue};

        _startPos = getPosASLVisual _startPosOrObj;
    };

    private _endPos = _endPosOrObj;
    if (_endPosOrObj isEqualType objNull) then {
        if (isNull _endPosOrObj) then {continue};

        _endPos = getPosASLVisual _endPosOrObj;
    };

    if (_drawIn3D) then {
        _scale = ICON_SCALE;
    } else {
        _scale = MAP_ICON_SCALE;
    };

    if (_scale < 0.01) then {
        continue;
    };

    private _visualProperties = [ICON, GVAR(color), _scale, ICON_ANGLE, LINEWIDTH];
    private _drawArgs = [_startPos, _endPos, _visualProperties, _formatters, _ctrlMap];
    if (_type in GVAR(plotTypes)) then {
        _drawArgs call (GVAR(plotTypes) get _type);
    };
} forEach (_activePlotWithMouseEndPos + _plots);
