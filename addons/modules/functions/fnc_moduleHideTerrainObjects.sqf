#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to hide terrain objects.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleHideTerrainObjects
 *
 * Public: No
 */

params ["_logic"];

private _position = ASLToAGL getPosASL _logic;
deleteVehicle _logic;

["STR_a3_to_hideTerrainObjects1", [
    ["TOOLBOX:YESNO", "STR_a3_to_hideTerrainObjects1", true],
    ["EDIT", ELSTRING(common,Range), 10],
    ["CHECKBOX", "STR_a3_to_hideTerrainObjects6", true], // Buildings
    ["CHECKBOX", "STR_a3_to_hideTerrainObjects7", true], // Walls & Fences
    ["CHECKBOX", "STR_a3_to_hideTerrainObjects8", true], // Vegetation
    ["CHECKBOX", "STR_a3_to_hideTerrainObjects9", true] // Other
], {
    params ["_values", "_position"];
    _values params ["_hide", "_range", "_includeBuildings", "_includeWalls", "_includePlants", "_includeOthers"];

    private _objectTypes = [];

    if (_includeBuildings) then {
        _objectTypes append ["BUILDING", "HOUSE", "CHURCH", "CHAPEL", "CROSS", "BUNKER", "FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "BUSSTOP", "TRANSMITTER", "STACK", "RUIN", "TOURISM", "WATERTOWER", "POWER LINES", "POWERSOLAR", "POWERWAVE", "POWERWIND"];
    };

    if (_includeWalls) then {
        _objectTypes append ["FENCE", "HIDE", "WALL"];
    };

    if (_includePlants) then {
        _objectTypes append ["TREE", "SMALL TREE", "BUSH", "FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE", "FOREST"];
    };

    if (_includeOthers) then {
        _objectTypes append ["ROCK", "ROCKS", "SHIPWRECK", "HIDE"];
    };

    {
        [QEGVAR(common,hideObjectGlobal), [_x, _hide]] call CBA_fnc_serverEvent;
    } forEach nearestTerrainObjects [_position, _objectTypes, parseNumber _range];
}, {}, _position] call EFUNC(dialog,create);
