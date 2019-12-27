#include "script_component.hpp"
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

if (!GVAR(declutterEmptyTree)) exitWith {};

params ["_display"];

// Get faction names for west, east, independent, and civilian sides
if (isNil QGVAR(factionNames)) then {
    GVAR(factionNames) = configProperties [configFile >> "CfgFactionClasses", "isClass _x"] select {
        getNumber (_x >> "side") in [0, 1, 2, 3]
    } apply {
        getText (_x >> "displayName")
    };
};

private _factionNames = GVAR(factionNames);

// Remove factions from empty tree
// Backwards since tree item paths will change as items are deleted
private _ctrlTree = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY;

for "_i" from (_ctrlTree tvCount []) - 1 to 0 step -1 do {
    if (_ctrlTree tvText [_i] in _factionNames) then {
        _ctrlTree tvDelete [_i];
    };
};
