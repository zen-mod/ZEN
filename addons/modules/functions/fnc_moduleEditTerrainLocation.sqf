#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to edit terrain locations.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleEditTerrainLocation
 *
 * Public: No
 */

params ["_logic"];

private _location = nearestLocation [_logic, ""];
private _type = type _location;
private _text = text _location;
private _direction = direction _location;
private _isRectangular = rectangular _location;
private _size = size _location;
private _name = name _location;
private _side = side _location;
private _importance = importance _location;

if (isNil QGVAR(locationTypes)) then {
    GVAR(locationTypes) = "true" configClasses (configFile >> "CfgLocationTypes") apply {configName _x};
};

private _sides = [
    east,
    west,
    independent,
    civilian,
    sideUnknown
];

[LSTRING(ModuleEditTerrainLocation), [
    [
        "COMBO",
        "str_3den_trigger_attribute_type_displayname",
        [GVAR(locationTypes), GVAR(locationTypes), GVAR(locationTypes) find _type]
    ],
    [
        "EDIT",
        "str_a3_cfgvehicles_modulecuratoraddicon_f_arguments_text",
        _text
    ],
    [
        "SLIDER",
        "STR_3DEN_Display3DEN_ControlsHint_Rotate",
        [0, 360, _direction, EFUNC(common,formatDegrees)]
    ],
    [
        "TOOLBOX",
        LSTRING(ModuleEditTerrainLocation_AreaShape),
        [_isRectangular, 1, 2, ["str_3den_attributes_shapetrigger_ellipse", "str_3den_attributes_shapetrigger_rectangle"]],
        true
    ],
    [
        "VECTOR",
        "str_3den_trigger_attribute_size_displayname",
        _size
    ],
    [
        "EDIT",
        "STR_3DEN_Display3DENSave_Filter_Name_text",
        _name
    ],
    [
        "COMBO",
        "str_a3_rscdisplaydynamicgroups_side",
        [_sides, _sides apply {[_x] call BIS_fnc_sideName}, _sides find _side]
    ],
    [
        "EDIT",
        LSTRING(ModuleEditTerrainLocation_Importance),
        _importance
    ]
], {
    [QGVAR(editTerrainLocation), _this] call CBA_fnc_globalEvent;
}, {}, _location] call EFUNC(dialog,create);

deleteVehicle _logic;
