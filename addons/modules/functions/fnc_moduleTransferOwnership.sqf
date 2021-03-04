#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to transfer ownership of objects and groups.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleTransferOwnership
 *
 * Public: No
 */

params ["_logic"];
deleteVehicle _logic;

if (!isMultiplayer) exitWith {
    [LSTRING(OnlyMultiplayer)] call EFUNC(common,showMessage);
};

private _entities = [];
call EFUNC(editor,getSelection) params ["_objects", "_groups"];
{
    if (isNull group _x) then {
        _entities pushBack _x;
    } else {
        _groups pushBackUnique group _x;
    };
} forEach _objects;
_entities append _groups;

if (_entities findIf {units _x findIf {isPlayer _x} > -1} != -1) exitWith {
    [LSTRING(SelectionCannotIncludePlayers)] call EFUNC(common,showMessage);
};

private _targets = [2, clientOwner];

private _targetNames = [
    LSTRING(ModuleTransferOwnership_Server),
    "str_a3_cfgvehicles_module_f_moduledescription_curator_f_1"
];

private _HCs = [];
private _players = [];
{
    if (_x isKindOf "HeadlessClient_F") then {
        _HCs pushBack [name _x, _x];
    } else {
        _players pushBack [name _x, _x];
    };
} forEach allPlayers;
_HCs sort true;
_players sort true;
{
    _x params ["_name", "_entity"];
    _targetNames pushBack _name;
    _targets pushBack _entity;
} forEach (_HCs + _players);

// Set default target to curator, server, or HC depending on current locality
private _defaultTarget = [
    1,
    [2, 0] select (_HCs isEqualTo [])
] select (local (_entities select 0));

[LSTRING(ModuleTransferOwnership), [
    [
        "COMBO",
        ELSTRING(common,Target),
        [_targets, _targetNames, _defaultTarget],
        true
    ],
    [
        "TOOLBOX",
        [LSTRING(ModuleTransferOwnership_HCScripts), LSTRING(ModuleTransferOwnership_HCScripts_Description)],
        [parseNumber (_defaultTarget == 2), 1, 2, [
            ELSTRING(common,Disabled),
            ELSTRING(common,Enabled)
        ]],
        true
    ]
], {
    params ["_values", "_args"];
    _values params ["_target", "_HCState"];
    _args params ["_entities"];

    // set headless client script flags
    if (_HCState < 2) then {
        if (isClass (configFile >> "CfgPatches" >> "acex_headless")) then {
            {
                _x setVariable ["ace_headless_blacklist", [false, true] select _HCState, true];
            } forEach _entities;
        };
    };

    [QEGVAR(common,transferOwnership), [_entities, _target]] call CBA_fnc_serverEvent;
}, {}, [_entities]] call EFUNC(dialog,create);
