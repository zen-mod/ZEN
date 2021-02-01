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

private _position = getPos _logic;
deleteVehicle _logic;

[localize "STR_a3_to_hideTerrainObjects1", [
    ["TOOLBOX:YESNO", "STR_a3_to_hideTerrainObjects1", true, true],
    ["EDIT", ELSTRING(common,Range), 10],
    ["CHECKBOX", "STR_ZEN_Modules_Buildings", true],
    ["CHECKBOX", "STR_A3_CfgEditorCategories_EdCat_Walls0", true],
    ["CHECKBOX", "STR_A3_CfgEditorSubcategories_EdSubcat_Plants0", true],
    ["CHECKBOX", "STR_A3_CfgEditorSubcategories_EdSubcat_Default0", true]
], {
    params ["_values", "_logic"];
    _values params ["_hide", "_range", "_hideBuildings", "_hideWalls", "_hidePlants", "_hideOthers"];

    private _objectTypes = [];
    if (_hideBuildings) then {
        _objectTypes append ["BUILDING", "HOUSE", "CHURCH", "CHAPEL", "CROSS", "BUNKER", "FORTRESS", "FOUNTAIN", "VIEW-TOWER", "LIGHTHOUSE", "QUAY", "FUELSTATION", "HOSPITAL", "BUSSTOP", "TRANSMITTER", "STACK", "RUIN", "TOURISM", "WATERTOWER", "POWER LINES", "POWERSOLAR", "POWERWAVE", "POWERWIND"];
    };

    if (_hideWalls) then {
        _objectTypes append ["FENCE", "HIDE", "WALL"];
    };

    if (_hidePlants) then {
        _objectTypes append ["TREE", "SMALL TREE", "BUSH", "FOREST BORDER", "FOREST TRIANGLE", "FOREST SQUARE", "FOREST"];
    };

    if (_hideOthers) then {
        _objectTypes append ["ROCK", "ROCKS", "SHIPWRECK", "HIDE"];
    };

    private _objects = nearestTerrainObjects [_position, _objectTypes, parseNumber _range];
    {
        [QEGVAR(common,hideObjectGlobal), [_x, _hide]] call CBA_fnc_serverEvent;
    } forEach _objects;
}, {
    params ["", "_logic"];
    deleteVehicle _position;
}, _logic] call EFUNC(dialog,create);
