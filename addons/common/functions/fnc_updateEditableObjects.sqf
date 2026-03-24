#include "script_component.hpp"
/*
 * Author: mharis001
 * Updates editable objects for the given (or all) curators.
 *
 * Arguments:
 * 0: Object(s) <ARRAY|OBJECT>
 * 1: Mode <BOOL> (default: true)
 *   - true: add objects, false: remove objects.
 * 2: Curator(s) <ARRAY|OBJECT> (default: [])
 *   - When given [] or objNull, changes are applied to all curators.
 * 3: Include Crew <BOOL> (default: true)
 *
 * Return Value:
 * None
 *
 * Example:
 * [_objects, true] call zen_common_fnc_updateEditableObjects
 *
 * Public: No
 */

if (!isServer) exitWith {
    [QGVAR(updateEditableObjects), _this] call CBA_fnc_serverEvent;
};

params [
    ["_objects", [], [[], objNull]],
    ["_mode", true, [true]],
    ["_curators", [], [[], objNull]],
    ["_includeCrew", true, [true]]
];

if (_objects isEqualType objNull) then {
    _objects = [_objects];
};

if (_curators in [[], objNull]) then {
    _curators = allCurators;
};

if (_curators isEqualType objNull) then {
    _curators = [_curators];
};

if (_mode) then {
    {
        _x addCuratorEditableObjects [_objects, _includeCrew];
    } forEach _curators;
} else {
    {
        _x removeCuratorEditableObjects [_objects, _includeCrew];
    } forEach _curators;
};
