#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to hide or show terrain objects.
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
    [
        "TOOLBOX",
        "str_3den_garbagecollection_attribute_mode_displayname",
        [true, 1, 2, ["STR_Disp_Show", "STR_Disp_Hide"]]
    ],
    ["SLIDER", ELSTRING(common,Radius_Units), [1, 1000, 10, 0]],
    ["CHECKBOX", "STR_a3_to_hideTerrainObjects6", true], // Buildings
    ["CHECKBOX", "STR_a3_to_hideTerrainObjects7", true], // Walls & Fences
    ["CHECKBOX", "STR_a3_to_hideTerrainObjects8", true], // Vegetation
    ["CHECKBOX", "STR_a3_to_hideTerrainObjects9", true] // Other
], {
    params ["_values", "_position"];
    _values params ["_hide", "_radius", "_includeBuildings", "_includeWalls", "_includeVegetation", "_includeOthers"];

    private _objectTypes = [];

    if (_includeBuildings) then {
        _objectTypes append ["BUILDING", "HOUSE", "CHURCH", "CHAPEL", "CROSS", "BUNKER", "FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "BUSSTOP", "TRANSMITTER", "STACK", "RUIN", "TOURISM", "WATERTOWER", "POWER LINES", "POWERSOLAR", "POWERWAVE", "POWERWIND"];
    };

    if (_includeWalls) then {
        _objectTypes append ["FENCE", "HIDE", "WALL"];
    };

    if (_includeVegetation) then {
        _objectTypes append ["TREE", "SMALL TREE", "BUSH", "FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE", "FOREST"];
    };

    if (_includeOthers) then {
        _objectTypes append ["ROCK", "ROCKS", "SHIPWRECK", "HIDE"];
    };

    [QGVAR(hideTerrainObjects), [_position, _objectTypes, _radius, _hide]] call CBA_fnc_serverEvent;
}, {}, _position] call EFUNC(dialog,create);
