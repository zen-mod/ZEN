#include "script_component.hpp"
/*
 * Author: Jonpas
 * Finds a localized string for the given hitpoint name.
 * Uses the hitpoint name if a string could not be found.
 *
 * Arguments:
 * 0: Hitpoint Name <STRING>
 *
 * Return Value:
 * Localized Hitpoint String <STRING>
 *
 * Example:
 * ["HitFuel"] call zen_common_fnc_getHitPointString
 *
 * Public: No
 */

params ["_hitPoint"];

// Prepare first part of the string from stringtable
private _text = LSTRING(Hit);

// Remove "Hit" from hitpoint name if one exists
private _toFind = if ((toLower _hitPoint) find "hit" == 0) then {
    [_hitPoint, 3] call CBA_fnc_substr
} else {
    _hitPoint
};

// Loop through always shorter part of the hitpoint name to find the string from stringtable
for "_i" from 0 to (count _hitPoint) do {
    // Localize if localization found
    private _combinedString = _text + _toFind;

    if (isLocalized _combinedString) exitWith {
        _text = localize _combinedString;
    };

    // Cut off one character
    _toFind = [_toFind, 0, count _toFind - 1] call CBA_fnc_substr;
};

// Use hitpoint name if a localized string was not found
if (_text == LSTRING(Hit)) then {
    _text = _hitPoint;
};

_text
