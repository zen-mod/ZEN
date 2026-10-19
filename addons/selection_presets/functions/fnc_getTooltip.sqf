#include "script_component.hpp"
/*
 * Author: mharis001
 * Returns tooltip text describing the given objects.
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: Preset Key <NUMBER>
 *
 * Return Value:
 * Tooltip Text <STRING>
 *
 * Example:
 * [_objects, 1] call zen_selection_presets_fnc_getTooltip
 *
 * Public: No
 */

#define MAX_ENTRIES 12

params ["_objects", "_key"];

if (_objects isEqualTo []) exitWith {""};

private _counts = createHashMap;

{
    private _name = getText (configOf _x >> "displayName");

    if (_name == "") then {
        _name = typeOf _x;
    };

    private _count = _counts getOrDefault [_name, 0];
    _counts set [_name, _count + 1];
} forEach _objects;

private _names = keys _counts;
_names sort true;

private _lines = [
    format [LLSTRING(TooltipHeader), _key]
];

private _namesToDisplay = _names select [0, MAX_ENTRIES];
private _remainingCount = count _objects;

{
    private _count = _counts get _x;
    _lines pushBack format [LLSTRING(TooltipEntry), _count, _x];
    _remainingCount = _remainingCount - _count;
} forEach _namesToDisplay;

if (_remainingCount > 0) then {
    _lines pushBack format [LLSTRING(TooltipRemaining), _remainingCount];
};

_lines joinString "\n"
