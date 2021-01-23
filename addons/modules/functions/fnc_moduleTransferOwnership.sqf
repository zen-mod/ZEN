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
(call EFUNC(editor,getSelection)) params ["_objects", "_groups"];
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
_targets append allPlayers;

private _targetNames = [
    LSTRING(ModuleTransferOwnership_Server),
    "str_a3_cfgvehicles_module_f_moduledescription_curator_f_1"
];
_targetNames append (allPlayers apply {name _x});

// Set default target to curator or server depending on current locality
private _defaultTarget = parseNumber !(local (_entities select 0));

[LSTRING(ModuleTransferOwnership), [
    [
        "COMBO",
        ELSTRING(common,Target),
        [_targets, _targetNames, _defaultTarget]
    ],
    [
        "TOOLBOX",
        LSTRING(ModuleTransferOwnership_HCScripts),
        [_defaultTarget, 1, 3, [
            ELSTRING(common,Enabled),
            ELSTRING(common,Disabled),
            ELSTRING(common,Unchanged)
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
