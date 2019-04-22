/*
 * Author: mharis001
 * Declutters empty unit tree by removing empty vehicles.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [DISPLAY] call zen_editor_fnc_declutterEmptyTree
 *
 * Public: No
 */
#include "script_component.hpp"

IF (!GVAR(declutterEmptyTree)) exitWith {};

params ["_display"];

// Get faction names for west, east, independent, and civilian
private _factionNames = [];

{
    if (getNumber (_x >> "side") in [0, 1, 2, 3]) then {
        _factionNames pushBack getText (_x >> "displayName");
    };
} forEach ("true" configClasses (configFile >> "CfgFactionClasses"));

// Remove factions from empty tree
// Backwards since tree item paths will change as items are deleted
private _ctrlTree = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY;

for "_i" from (_ctrlTree tvCount []) - 1 to 0 step -1 do {
    if (_ctrlTree tvText [_i] in _factionNames) then {
        _ctrlTree tvDelete [_i];
    };
};
