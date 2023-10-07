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
 * [LOGIC] call zen_modules_fnc_moduleLocation
 *
 * Public: No
 */

params ["_logic"];

_location = nearestLocation [getPosASL _logic, ""];

private _type = type _location;
private _text = text _location;
private _direction = direction _location;
private _isRectangular = rectangular _location;
private _size = size _location;
private _name = name _location;
private _side = side _location;
private _importance = importance _location;

private _types = ["Mount","Name","Strategic","StrongpointArea","FlatArea","FlatAreaCity","FlatAreaCitySmall","CityCenter","Airport","NameMarine","NameCityCapital","NameCity","NameVillage","NameLocal","Hill","ViewPoint","RockArea","BorderCrossing","VegetationBroadleaf","VegetationFir","VegetationPalm","VegetationVineyard","Area","Flag","Invisible","HistoricalSite","CivilDefense","CulturalProperty","DangerousForces","SafetyZone","HandDrawnCamp","b_unknown","o_unknown","n_unknown","b_inf","o_inf","n_inf","b_motor_inf","o_motor_inf","n_motor_inf","b_mech_inf","o_mech_inf","n_mech_inf","b_armor","o_armor","n_armor","b_recon","o_recon","n_recon","b_air","o_air","n_air","b_plane","o_plane","n_plane","b_uav","o_uav","n_uav","b_naval","o_naval","n_naval","b_med","o_med","n_med","b_art","o_art","n_art","b_mortar","o_mortar","n_mortar","b_hq","o_hq","n_hq","b_support","o_support","n_support","b_maint","o_maint","n_maint","b_service","o_service","n_service","b_installation","o_installation","n_installation","u_installation","b_antiair","o_antiair","n_antiair","c_unknown","c_car","c_ship","c_air","c_plane","group_0","group_1","group_2","group_3","group_4","group_5","group_6","group_7","group_8","group_9","group_10","group_11","respawn_unknown","respawn_inf","respawn_motor","respawn_armor","respawn_air","respawn_plane","respawn_naval","respawn_para"];
private _sides = [
    east,
    west,
    independent,
    civilian,
    sideUnknown
];

private _attributes = [
    ["COMBO", "str_3den_trigger_attribute_type_displayname", [_types,_types, _types find _type]],
    ["EDIT", "str_a3_cfgvehicles_modulecuratoraddicon_f_arguments_text", _text, true],
    ["SLIDER", "STR_3DEN_Display3DEN_ControlsHint_Rotate", [0, 360, _direction, EFUNC(common,formatDegrees)], true],
    ["TOOLBOX", "str_3den_trigger_attribute_shape_tooltip", [parseNumber _isRectangular, 1, 2, ["str_3den_attributes_shapetrigger_ellipse", "str_3den_attributes_shapetrigger_rectangle"]]],
    ["EDIT", format ["%1 %2", localize "str_3den_trigger_attribute_size_displayname",localize "str_3den_axis_x"], _size select 0, true],
    ["EDIT", format ["%1 %2", localize "str_3den_trigger_attribute_size_displayname",localize "str_3den_axis_y"], _size select 1, true],
    ["EDIT", "STR_3DEN_Display3DENSave_Filter_Name_text", _name, true],
    ["COMBO", "str_a3_rscdisplaydynamicgroups_side", [_sides, [
        "OPFOR",
        "BLUFOR",
        "Independent",
        "Civilian",
        "Unknown"
    ], _sides find _side]],
    ["EDIT", LSTRING(ModuleLocation_Importance), _importance, true]
];

["STR_3DEN_Display3DEN_Locations", _attributes, {
    params ["_dialogValues", "_location"];
    _dialogValues params [
        "_type",
        "_text",
        "_direction",
        "_isRectangular",
        "_sizeX",
        "_sizeY",
        "_name",
        "_side",
        "_importance"
    ];

    private _location = createLocation [_location];

    _location setType _type;
    _location setText _text;
    _location setDirection _direction;
    _location setRectangular ([false, true] select _isRectangular);
    _location setSize [parseNumber _sizeX, parseNumber _sizeY];
    _location setName _name;
    _location setSide _side;
    _location setImportance parseNumber _importance;

    deleteLocation _location;
}, {}, _location] call EFUNC(dialog,create);

deleteVehicle _logic;
