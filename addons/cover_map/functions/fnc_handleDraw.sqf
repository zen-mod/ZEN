#include "script_component.hpp"
/*
 * Author: mharis001
 * Handles drawing the current area on the map.
 *
 * Arguments:
 * 0: Map <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_cover_map_fnc_handleDraw
 *
 * Public: No
 */

params ["_ctrlMap"];

private _area = _ctrlMap getVariable QGVAR(area);
private _areaExists = !isNil "_area";

// Draw the current area if it exists
if (_areaExists) then {
    _area params ["_center", "_size", "_angle"];
    _size params ["_sizeX", "_sizeY"];

    _ctrlMap drawRectangle [_center, _sizeX, _sizeY, _angle, [1, 1, 1, 1], "#(rgb,8,8,3)color(1,0,0,0.25)"];
};

// Enable the delete button if an area exists
private _display = ctrlParent _ctrlMap;
private _ctrlDelete = _display displayCtrl IDC_CM_DELETE;
_ctrlDelete ctrlEnable _areaExists;
