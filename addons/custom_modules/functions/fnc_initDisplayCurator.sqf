#include "script_component.hpp"
/*
 * Author: mharis001
 * Adds custom modules to the Zeus modules tree.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_custom_modules_fnc_addModules
 *
 * Public: No
 */

if (isNil QGVAR(list)) exitWith {};

BEGIN_COUNTER(init);

params ["_display"];

private _ctrlTree = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;

// Get already present categories to prevent creating duplicate ones
private _categories = [];

for "_i" from 0 to ((_ctrlTree tvCount []) - 1) do {
    _categories pushBack (_ctrlTree tvText [_i]);
};

// Add custom modules to tree and sort items
{
    _x params ["_category", "_name", "_icon"];

    private _categoryIndex = _categories find _category;

    if (_categoryIndex == -1) then {
        _categoryIndex = _ctrlTree tvAdd [[], _category];
        _categories pushBack _category;
    };

    private _index = _ctrlTree tvAdd [[_categoryIndex], _name];
    private _path = [_categoryIndex, _index];
    _ctrlTree tvSetTooltip [_path, _name];
    _ctrlTree tvSetData [_path, format [QGVAR(%1), _forEachIndex + 1]];
    _ctrlTree tvSetPicture [_path, _icon];
} forEach GVAR(list);

_ctrlTree tvSortAll [[], false];

END_COUNTER(init);
