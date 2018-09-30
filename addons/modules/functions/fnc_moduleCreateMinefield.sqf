/*
 * Author: mharis001
 * Creates minefield of given area around the center position.
 *
 * Arguments:
 * 0: Center position AGL <ARRAY>
 * 1: Area width <NUMBER>
 * 2: Area height <NUMBER>
 * 3: Mine type <STRING>
 * 4: Mine density (0 - low to 4 - high) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0], 100, 100, "ModuleMine_APERSMine_F", 2] call zen_modules_fnc_moduleCreateMinefield
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_centerPos", "_areaWidth", "_areaHeight", "_mineType", "_mineDensity"];
TRACE_1("Module Create Minefield",_this);

private _createdMines = [];

// Determine spacing based on density
private _mineSpacing = -5 * _mineDensity + 30;
private _topLeftPos = _centerPos vectorAdd [-_areaWidth / 2, -_areaHeight / 2, 0];

// Create minefield
for "_i" from _mineSpacing / 2 to _areaWidth step _mineSpacing do {
    for "_j" from _mineSpacing / 2 to _areaHeight step _mineSpacing do {
        private _mine = createVehicle [_mineType, [0, 0, 0], [], 0, "CAN_COLLIDE"];
        _mine setPos (_topLeftPos vectorAdd [_i, _j, 0]);
        _createdMines pushBack _mine;
    };
};

TRACE_1("Minefield created",count _createdMines);

// Add created mines to Zeus
[QEGVAR(common,addObjects), [_createdMines]] call CBA_fnc_serverEvent;
