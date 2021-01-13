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

if (!isMultiplayer) exitWith {
    [LSTRING(OnlyMultiplayer)] call EFUNC(common,showMessage);
    deleteVehicle _logic;
};

deleteVehicle _logic;

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

if (_entities findIf {units _x findIf {isPlayer _x} > -1} > -1) exitWith {
    [LSTRING(SelectionCannotIncludePlayers)] call EFUNC(common,showMessage);
};

private _defaultTarget = !local (_entities select 0);
private _clientTypes = allPlayers;
private _clientNames = allPlayers apply {name _x};
_clientTypes = [0] + _clientTypes;
_clientNames = ["str_a3_om_common_definitions.incphone_44"] + _clientNames;

[LSTRING(ModuleTransferOwnership), [
    [
        "TOOLBOX",
        ELSTRING(common,Target),
        [_defaultTarget, 1, 3, [
            LSTRING(ModuleTransferOwnership_Server),
            "str_a3_cfgvehicles_module_f_moduledescription_curator_f_1",
            LSTRING(ModuleTransferOwnership_Client)
        ]],
        true
    ],
    [
        "COMBO",
        LSTRING(ModuleTransferOwnership_Client),
        [_clientTypes, _clientNames, 0]
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
    _values params ["_target", "_player", "_HCState"];
    _args params ["_entities", "_mehID"];

    // Stop drawing icons
    if (_mehID > 0) then {
        removeMissionEventHandler ["Draw3D", _mehID];
    };
    private _targetID = switch (_target) do {
        case (0): {
            2 // Server
        };
        case (1): {
            clientOwner
        };
        case (2): {
            _player
        };
    };

    // set headless client script flags
    if (_HCState < 2) then {
        if (isClass (configFile >> "CfgPatches" >> "acex_headless")) then {
            {
                _x setVariable ["ace_headless_blacklist", [false, true] select _HCState, true];
            } forEach _entities;
        };
    };

    [QEGVAR(common,transferOwnership), [_entities, _targetID]] call CBA_fnc_serverEvent;
}, {
    params ["", "_args"];
    _args params ["", "_mehID"];

    // Stop drawing icons
    if (_mehID > 0) then {
        removeMissionEventHandler ["Draw3D", _mehID];
    };
}, [_entities, _mehID]] call EFUNC(dialog,create);
