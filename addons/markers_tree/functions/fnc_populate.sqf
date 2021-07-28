#include "script_component.hpp"
/*
 * Author: mharis001
 * Populates the custom markers tree.
 *
 * Arguments:
 * 0: Markers Tree <CONTROL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [CONTROL] call zen_markers_tree_fnc_populate
 *
 * Public: No
 */

params ["_ctrlTree"];

{
    private _categoryIndex = _ctrlTree tvAdd [[], _x];

    {
        _x params ["_class", "_name", "_icon", "_color"];

        private _index = _ctrlTree tvAdd [[_categoryIndex], _name];
        private _path  = [_categoryIndex, _index];

        _ctrlTree tvSetData [_path, _class];
        _ctrlTree tvSetTooltip [_path, _name];
        _ctrlTree tvSetPicture [_path, _icon];
        _ctrlTree tvSetPictureColor [_path, _color];
        _ctrlTree tvSetPictureColorSelected [_path, _color];
    } forEach _y;
} forEach (uiNamespace getVariable QGVAR(cache));

_ctrlTree tvSortAll [[], false];
