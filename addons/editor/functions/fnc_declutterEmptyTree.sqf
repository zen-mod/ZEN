#include "script_component.hpp"
/*
 * Author: mharis001
 * Declutters the empty unit tree by removing empty vehicles.
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

// Remove factions from empty tree
// Backwards since tree item paths will change as items are deleted
private _ctrlTree = _display displayCtrl IDC_RSCDISPLAYCURATOR_CREATE_UNITS_EMPTY;
private _fastDeclutterFactions = uiNamespace getVariable [QGVAR(fastDeclutterFactions), createHashMap];
private _slowDeclutterFactions = uiNamespace getVariable [QGVAR(slowDeclutterFactions), createHashMap];
private _forcedEmptyObjects = uiNamespace getVariable [QGVAR(forcedEmptyObjects), createHashMap];

for "_i" from (_ctrlTree tvCount []) - 1 to 0 step -1 do {
    private _faction = _ctrlTree tvText [_i];

    // Delete entire node for factions that do not contain any forced empty objects (fast case)
    if (_faction in _fastDeclutterFactions) then {
        _ctrlTree tvDelete [_i];
        continue;
    };

    // For factions that contain forced empty objects, need to check every leaf node individually (slow case)
    if (_faction in _slowDeclutterFactions) then {
        for "_j" from (_ctrlTree tvCount [_i]) - 1 to 0 step -1 do {
            for "_k" from (_ctrlTree tvCount [_i, _j]) - 1 to 0 step -1 do {
                private _data = _ctrlTree tvData [_i, _j, _k];
                if (_data in _forcedEmptyObjects) then {continue};
                _ctrlTree tvDelete [_i, _j, _k];
            };

            if (_ctrlTree tvCount [_i, _j] == 0) then {
                _ctrlTree tvDelete [_i, _j];
            };
        };

        if (_ctrlTree tvCount [_i] == 0) then {
            _ctrlTree tvDelete [_i];
        };
    };
};
