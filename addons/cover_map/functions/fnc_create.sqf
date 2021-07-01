#include "script_component.hpp"
/*
 * Author: Bohemia Interactive, mharis001
 * Creates the cover map effect.
 *
 * Arguments:
 * 0: Center <ARRAY>
 * 1: Size <ARRAY>
 * 3: Rotation <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0], [1000, 1000], 0] call zen_cover_map_fnc_create
 *
 * Public: No
 */

#define SIZE_OUT 100000

params [
    ["_center", [0, 0], [[]], [2, 3]],
    ["_size", [0, 0], [[]], 2],
    ["_angle", 0, [0]]
];

_center params [
    ["_centerX", 0, [0]],
    ["_centerY", 0, [0]]
];

_size params [
    ["_sizeX", 0, [0]],
    ["_sizeY", 0, [0]]
];

// Remove an already existent cover map effect first
[] call FUNC(remove);

// Create cover and corner markers
{
    private _direction = _angle + _x;
    private _sizeA = [_sizeX, _sizeY] select abs cos _x;
    private _sizeB = [_sizeX, _sizeY] select abs sin _x;
    private _sizeMarker = [_sizeB, SIZE_OUT] select abs sin _x;

    private _coverPos = [
        _centerX + sin _direction * SIZE_OUT,
        _centerY + cos _direction * SIZE_OUT
    ];

    private _markerCover = createMarker [format [QGVAR(cover_%1), _x], _coverPos];
    _markerCover setMarkerShape "RECTANGLE";
    _markerCover setMarkerBrush "Solid";
    _markerCover setMarkerColor "ColorBlack";
    _markerCover setMarkerSize [_sizeMarker, SIZE_OUT - _sizeA];
    _markerCover setMarkerDir _direction;

    private _dotPos = [
        _centerX + sin _direction * _sizeA + sin (_direction + 90) * _sizeB,
        _centerY + cos _direction * _sizeA + cos (_direction + 90) * _sizeB
    ];

    private _markerDot = createMarker [format [QGVAR(dot_%1), _x], _dotPos];
    _markerDot setMarkerColor "ColorBlack";
    _markerDot setMarkerType "mil_box_noShadow";
    _markerDot setMarkerSize [0.75, 0.75];
    _markerDot setMarkerDir _direction;
} forEach [0, 90, 180, 270];

// Create border marker
private _markerBorder = createMarker [QGVAR(border), [_centerX, _centerY]];
_markerBorder setMarkerShape "RECTANGLE";
_markerBorder setMarkerBrush "Border";
_markerBorder setMarkerColor "ColorBlack";
_markerBorder setMarkerSize [_sizeX, _sizeY];
_markerBorder setMarkerDir _angle;
