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

private _markersCache = uiNamespace getVariable QGVAR(cache);

{
    _x params ["_category", "_markers"];

    private _categoryIndex = _ctrlTree tvAdd [[], _category];

    {
        _x params ["_class", "_name", "_icon", "_color"];

        private _index = _ctrlTree tvAdd [[_categoryIndex], _name];
        private _path  = [_categoryIndex, _index];

        _ctrlTree tvSetData [_path, _class];
        _ctrlTree tvSetTooltip [_path, _name];
        _ctrlTree tvSetPicture [_path, _icon];
        _ctrlTree tvSetPictureColor [_path, _color];
        _ctrlTree tvSetPictureColorSelected [_path, _color];
    } forEach _markers;
} forEach _markersCache;

_ctrlTree tvSort [[], false];

for "_i" from 0 to ((_ctrlTree tvCount []) - 1) do {
    _ctrlTree tvSort [[_i], false];
};
