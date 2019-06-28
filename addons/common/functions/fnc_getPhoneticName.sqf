/*
 * Author: mharis001
 * Returns a phonetic name based on the index.
 * Adds a suffix if the index is greater than 25.
 *
 * Arguments:
 * 0: Index <NUMBER>
 *
 * Return Value:
 * Name <STRING>
 *
 * Example:
 * [0] call zen_common_fnc_getPhoneticName
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_index"];

// BIS_fnc_phoneticalWord only accepts index from 1 to 26
private _name = [_index % 26 + 1] call BIS_fnc_phoneticalWord;

// Add number suffix if index is greater than the number of words
if (_index > 25) then {
    _name = format ["%1 - %2", _name, floor (_index / 26)];
};

_name
