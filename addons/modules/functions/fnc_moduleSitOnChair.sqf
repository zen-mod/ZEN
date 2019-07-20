#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to make a unit sit on a chair.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleSitOnChair
 *
 * Public: No
 */

#define CHAIR_CLASSES [ \
    "Land_CampingChair_V1_F", \
    "Land_CampingChair_V2_F", \
    "Land_ChairPlastic_F", \
    "Land_ChairWood_F", \
    "Land_OfficeChair_01_F", \
    "Land_WoodenLog_F", \
    "Land_RattanChair_01_F", \
    "Land_ArmChair_01_F" \
]

#define CHAIR_POSITIONS [ \
    [0, -0.1, -0.45], \
    [0, -0.1, -0.45], \
    [0, 0, -0.5], \
    [0, -0.05, 0], \
    [0, 0, -0.6], \
    [0, 0.05, -0.2], \
    [0, -0.1, -0.5], \
    [0, 0, -0.5] \
]

#define CHAIR_DIRECTIONS [ \
    180, \
    180, \
    90, \
    180, \
    180, \
    0, \
    180, \
    0 \
]

#define SITTING_ANIMS [ \
    "HubSittingChairA_idle1", \
    "HubSittingChairA_idle2", \
    "HubSittingChairA_idle3", \
    "HubSittingChairA_move1", \
    "HubSittingChairB_idle1", \
    "HubSittingChairB_idle2", \
    "HubSittingChairB_idle3", \
    "HubSittingChairB_move1", \
    "HubSittingChairC_idle1", \
    "HubSittingChairC_idle2", \
    "HubSittingChairC_idle3", \
    "HubSittingChairC_move1", \
    "HubSittingChairUA_idle1", \
    "HubSittingChairUA_idle2", \
    "HubSittingChairUA_idle3", \
    "HubSittingChairUA_move1", \
    "HubSittingChairUB_idle1", \
    "HubSittingChairUB_idle2", \
    "HubSittingChairUB_idle3", \
    "HubSittingChairUB_move1", \
    "HubSittingChairUC_idle1", \
    "HubSittingChairUC_idle2", \
    "HubSittingChairUC_idle3", \
    "HubSittingChairUC_move1" \
]

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

if (isNull _unit) exitWith {
    [LSTRING(NoUnitSelected)] call EFUNC(common,showMessage);
};

if !(_unit isKindOf "CAManBase") exitWith {
    [LSTRING(OnlyInfantry)] call EFUNC(common,showMessage);
};

if !(alive _unit) exitWith {
    [LSTRING(OnlyAlive)] call EFUNC(common,showMessage);
};

if (isPlayer _unit) exitWith {
    ["str_a3_cfgvehicles_moduleremotecontrol_f_errorPlayer"] call EFUNC(common,showMessage);
};

// Make unit stand up if already sitting
if (_unit getVariable [QGVAR(isSitting), false]) exitWith {
    [QEGVAR(common,switchMove), [_unit, ""]] call CBA_fnc_globalEvent;
    _unit setVariable [QGVAR(isSitting), false, true];
    detach _unit;
};

// Filter chair classes to existent ones and get display names
private _cfgVehicles = configFile >> "CfgVehicles";
private _configNames = CHAIR_CLASSES select {isClass (_cfgVehicles >> _x)};
private _displayNames = _configNames apply {getText (_cfgVehicles >> _x >> "displayName")};

[LSTRING(ModuleSitOnChair), [
    ["COMBO", LSTRING(ModuleSitOnChair_ChairObject), [_configNames, _displayNames, 0]]
], {
    params ["_dialogValues", "_unit"];
    _dialogValues params ["_chairClass"];

    // Play a random sitting animation on the unit
    [QEGVAR(common,switchMove), [_unit, selectRandom SITTING_ANIMS]] call CBA_fnc_globalEvent;

    // Get sitting parameters for selected chair class
    private _index = CHAIR_CLASSES find _chairClass;
    private _sitPosition = CHAIR_POSITIONS select _index;
    private _sitDirection = CHAIR_DIRECTIONS select _index;

    // Create the chair in the direction the unit is currently facing
    private _chair = createVehicle [_chairClass, _unit, [], 0, "CAN_COLLIDE"];
    _chair setDir (getDir _unit - _sitDirection);

    _unit attachTo [_chair, _sitPosition];
    [QEGVAR(common,setDir), [_unit, _sitDirection], _unit] call CBA_fnc_targetEvent;

    // Add chair to editable objects so it can be moved around
    [QEGVAR(common,addObjects), [[_chair]]] call CBA_fnc_serverEvent;

    // Flag unit as sitting so module will make it stand up next time
    _unit setVariable [QGVAR(isSitting), true, true];
}, {}, _unit] call EFUNC(dialog,create);
