#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles pressing a mouse button on the map.
 *
 * Arguments:
 * 0: Map <CONTROL>
 * 1: Button <NUMBER>
 * 2: X Position <NUMBER>
 * 3: Y Position <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL, 0, 0.5, 0.5] call zen_cover_map_fnc_handleMouseButtonDown
 *
 * Public: No
 */

params ["_ctrlMap", "_button", "_posX", "_posY"];

if (_button == 0) then {
    private _position = _ctrlMap ctrlMapScreenToWorld [_posX, _posY];
    private _area = _ctrlMap getVariable QGVAR(area);

    // If the area does not exist, start creating a new one
    if (isNil "_area") then {
        _ctrlMap setVariable [QGVAR(corner), _position];
    } else {
        _area params ["_center", "_size", "_angle"];
        _size params ["_sizeX", "_sizeY"];

        // If the clicked position is in the area, start moving it
        // Otherwise, start creating a new one
        if (_position inArea [_center, _sizeX, _sizeY, _angle, true, -1]) then {
            private _offset = _center vectorDiff _position;
            _ctrlMap setVariable [QGVAR(offset), _offset];
        } else {
            _ctrlMap setVariable [QGVAR(corner), _position];
        };
    };
};
