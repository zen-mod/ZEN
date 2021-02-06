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

if (isNil QGVAR(modulesList)) exitWith {};

params ["_display"];

private _ctrlTree = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_MODULES;

if (isNil QGVAR(categories)) then {
    GVAR(categories) = [];

    for "_i" from 0 to ((_ctrlTree tvCount []) - 1) do {
        GVAR(categories) pushBack (_ctrlTree tvText [_i]);
    };
};

private _categories = +GVAR(categories);

{
    _x params ["_category", "_displayName", "_icon"];

    private _categoryIndex = _categories find _category;

    if (_categoryIndex == -1) then {
        _categoryIndex = _ctrlTree tvAdd [[], _category];
        _categories pushBack _category;
    };

    private _index = _ctrlTree tvAdd [[_categoryIndex], _displayName];
    private _path = [_categoryIndex, _index];

    _ctrlTree tvSetTooltip [_path, _displayName];
    _ctrlTree tvSetData [_path, format [QGVAR(module_%1), _forEachIndex + 1]];
    _ctrlTree tvSetPicture [_path, _icon];
} forEach GVAR(modulesList);

_ctrlTree tvSort [[], false];

for "_i" from 0 to ((_ctrlTree tvCount []) - 1) do {
    _ctrlTree tvSort [[_i], false];
};
