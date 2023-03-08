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
    [
        "VECTOR",
        LSTRING(ModuleCreateMinefield_MineArea),
        [100, 100]
    ],
    [
        "COMBO",
        LSTRING(ModuleCreateMinefield_MineType),
        [_configNames, _displayNames, 0]
    ],
    [
        "TOOLBOX",
        LSTRING(ModuleCreateMinefield_MineDensity),
        [2, 1, 5, [
            ELSTRING(common,VeryLow),
            ELSTRING(common,Low),
            ELSTRING(common,Medium),
            ELSTRING(common,High),
            ELSTRING(common,VeryHigh)
        ]]
    ],
    [
        "TOOLBOX:YESNO",
        [LSTRING(ModuleCreateMinefield_RandomPlacement), LSTRING(ModuleCreateMinefield_RandomPlacement_Tooltip)],
        false
    ]
], {
    params ["_values", "_position"];
    _values params ["_area", "_type", "_density", "_randomize"];
    _area params ["_width", "_height"];

    private _mines = [];

    // Determine spacing based on density
    private _spacing = 50 - 10 * _density;

    if (_randomize) then {
        // Create rectangular area array to get random positions from
        _area = [_position, _width / 2, _height / 2, 0, true];

        for "_i" from 1 to (_width / _spacing * _height / _spacing) do {
            private _position = [_area] call CBA_fnc_randPosArea;
            private _mine = createVehicle [_type, _position, [], 0, "CAN_COLLIDE"];
            _mine setDir random 360;
            _mines pushBack _mine;
        };
    } else {
        private _topLeft = _position vectorAdd [-_width / 2, -_height / 2, 0];

        for "_i" from _spacing / 2 to _width step _spacing do {
            for "_j" from _spacing / 2 to _height step _spacing do {
                private _position = _topLeft vectorAdd [_i, _j, 0];
                _mines pushBack createVehicle [_type, _position, [], 0, "CAN_COLLIDE"];
            };
        };
    };

    // Add created mines to editable objects
    [_mines] call EFUNC(common,updateEditableObjects);
}, {}, ASLtoAGL getPosASL _logic] call EFUNC(dialog,create);

deleteVehicle _logic;
