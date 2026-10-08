#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to update editable objects.
 *
 * Arguments:
 * 0: Position <ARRAY>
 * 1: Editing Mode <BOOL>
 * 2: Curator <OBJECT>
 * 3: Range <NUMBER>
 * 4: Filter <ARRAY>
 * 5: Alive Mode <NUMBER>
 *   - 0: Dead only.
 *   - 1: Alive only.
 *   - 2: Either dead or alive.
 *
 * Return Value:
 * None
 *
 * Example:
 * [[0, 0, 0], true, objNull, -1, [true, true, true, true], 2] call zen_modules_fnc_moduleEditableObjects
 *
 * Public: No
 */
params ["_position", "_editingMode", "_curator", "_range", "_filter", "_alive"];
_filter params ["_allowAll", "_allowUnits", "_allowVehicles", "_allowStatic"];

private _objects = [];

if (_range == -1) then {
    if (_allowAll) then {
        _objects = allMissionObjects "All";
    } else {
        if (_allowUnits) then {
            _objects append allUnits + allDeadMen;
        };

        if (_allowVehicles) then {
            _objects append vehicles;
        };

        if (_allowStatic) then {
            _objects append allMissionObjects "Static" + allMissionObjects "Thing";
        };
    };
} else {
    private _types = [];

    if (_allowAll) then {
        _types = ["All"];
    } else {
        if (_allowUnits) then {
            _types append ["CAManBase"];
        };

        if (_allowVehicles) then {
            _types append ["LandVehicle", "Air", "Ship"];
        };

        if (_allowStatic) then {
            _types append ["Static", "Thing"];
        };
    };

    _objects = nearestObjects [_position, _types, _range, true];
};

private _aliveFilter = [{!alive _x}, {alive _x}, {true}] select _alive;
_objects = _objects select _aliveFilter;

[_objects, _editingMode, _curator] call EFUNC(common,updateEditableObjects);
