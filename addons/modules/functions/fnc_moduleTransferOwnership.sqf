#include "script_component.hpp"
/*
 * Author: Ampersand
 * Zeus module function to transfer ownership of objects.
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

if (!isMultiplayer) exitWith {
 [LSTRING(OnlyMultiplayer)] call EFUNC(common,showMessage);
};

params ["_logic"];

private _unit = attachedTo _logic;
deleteVehicle _logic;

private _clientTypes = allPlayers;
private _clientNames = allPlayers apply {name _x};
if (!isServer) then {
    _clientTypes = [0] + _clientTypes;
    _clientNames = ["str_a3_om_common_definitions.incphone_44"] + _clientNames;
};

private _entities = [];
private _mehID = -1;
if (isNull _unit) then {
    _mehID = ["\a3\ui_f\data\Map\VehicleIcons\iconVirtual_ca.paa"] call EFUNC(editor,drawSavedSelectionIcons);
    EGVAR(editor,savedSelection) params ["_objects", "_groups"];
    {
        if (isNull group _x) then {
            _entities pushBack _x;
        } else {
            _groups pushBackUnique group _x;
        };
    } forEach _objects;
    _entities append _groups;
} else {
    _entities = [[group _unit, _unit] select (isNull group _unit)];
};

private _defaultTarget = !local (_entities select 0);
[LSTRING(ModuleTransferOwnership), [
    [
        "TOOLBOX",
        ELSTRING(common,Target),
        [_defaultTarget, 1, 3, [
            LSTRING(ModuleTransferOwnership_Server),
            "str_a3_cfgvehicles_module_f_moduledescription_curator_f_1",
            LSTRING(ModuleTransferOwnership_Client)
        ]]
    ],
    [
        "COMBO",
        LSTRING(ModuleTransferOwnership_Client),
        [_clientTypes, _clientNames, 0]
    ]
], {
    params ["_values", "_args"];
    _values params ["_target", "_player"];
    _args params ["_entities", "_mehID"];
    if (_mehID > 0) then {
        removeMissionEventHandler ["Draw3D", _mehID];
    };
    private _targetID = switch (_target) do {
        case (0): {
            2
        };
        case (1): {
            clientOwner
        };
        case (2): {
            _player
        };
    };
    [QEGVAR(common,transferOwnership), [_entities, _targetID]] call CBA_fnc_serverEvent;
}, {
    params ["", "_args"];
    _args params ["", "_mehID"];
    if (_mehID > 0) then {
        removeMissionEventHandler ["Draw3D", _mehID];
    };
}, [_entities, _mehID]] call EFUNC(dialog,create);
