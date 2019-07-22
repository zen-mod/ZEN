#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create a minefield.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleCreateMinefield
 *
 * Public: No
 */

params ["_logic"];

private _minesCache = +(uiNamespace getVariable QGVAR(minesCache));
_minesCache params ["_configNames", "_displayNames"];

[LSTRING(ModuleCreateMinefield), [
    ["VECTOR", LSTRING(ModuleCreateMinefield_MineArea), [100, 100]],
    ["COMBO", LSTRING(ModuleCreateMinefield_MineType), [_configNames, _displayNames, 0]],
    ["TOOLBOX", LSTRING(ModuleCreateMinefield_MineDensity), [2, 1, 5, [ELSTRING(common,VeryLow), ELSTRING(common,Low), ELSTRING(common,Medium), ELSTRING(common,High), ELSTRING(common,VeryHigh)]]]
], {
    params ["_dialogValues", "_position"];
    _dialogValues params ["_area", "_mineType", "_mineDensity"];
    _area params ["_areaWidth", "_areaHeight"];

    private _createdMines = [];

    // Determine spacing based on density
    private _mineSpacing = -5 * _mineDensity + 30;
    private _topLeftPos = _position vectorAdd [-_areaWidth / 2, -_areaHeight / 2, 0];

    // Create minefield of given area
    for "_i" from _mineSpacing / 2 to _areaWidth step _mineSpacing do {
        for "_j" from _mineSpacing / 2 to _areaHeight step _mineSpacing do {
            private _mine = createVehicle [_mineType, [0, 0, 0], [], 0, "CAN_COLLIDE"];
            _mine setPos (_topLeftPos vectorAdd [_i, _j, 0]);
            _createdMines pushBack _mine;
        };
    };

    // Add created mines to editable objects
    [QEGVAR(common,addObjects), [_createdMines]] call CBA_fnc_serverEvent;
}, {}, ASLtoAGL getPosASL _logic] call EFUNC(dialog,create);

deleteVehicle _logic;
