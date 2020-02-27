#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns a position logic of the given type based on the selection mode.
 * Mode strings and their number equivalents are: random (-3), nearest (-2), farthest (-1).
 * The selection mode can also be an index to select a specific logic.
 * Position is only used when the mode is based on distance (farthest or nearest).
 * objNull is returned if the list is empty or an invalid mode is provided.
 *
 * Arguments:
 * 0: Type <STRING|OBJECT>
 * 1: Mode <STRING|NUMBER>
 * 2: Position <ARRAY|OBJECT> (default: [0, 0, 0])
 *
 * Return Value:
 * Logic <OBJECT>
 *
 * Example:
 * [_logicType, "nearest", [0, 0, 0]] call zen_position_logics_fnc_select
 *
 * Public: No
 */

params [
    ["_type", "", ["", objNull]],
    ["_mode", "", ["", 0]],
    ["_position", [0, 0, 0], [[], objNull], 3]
];

private _list = _type call FUNC(get);

// Exit if the list is empty
if (_list isEqualTo []) exitWith {objNull};

// Convert mode string to mode number
if (_mode isEqualType "") then {
    _mode = (["random", "nearest", "farthest"] find _mode) - 3;
};

// Select position logic based on the mode
switch (_mode) do {
    case -3: { // Random
        selectRandom _list
    };
    case -2: { // Nearest
        private _distances = _list apply {_x distance _position};
        _list select (_distances find selectMin _distances)
    };
    case -1: { // Farthest
        private _distances = _list apply {_x distance _position};
        _list select (_distances find selectMax _distances)
    };
    default { // Specific
        _list param [_mode, objNull]
    };
};
