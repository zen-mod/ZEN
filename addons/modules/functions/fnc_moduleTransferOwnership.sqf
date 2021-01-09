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
    _clientTypes = [2] + _clientTypes;
    _clientNames = ["Server"] + _clientNames;
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

[LSTRING(ModuleTransferOwnership), [
    [
        "COMBO",
        ELSTRING(common,Target),
        [_clientTypes, _clientNames, 0]
    ]
], {
    params ["_values", "_args"];
    _args params ["_entities", "_mehID"];
    if (_mehID > 0) then {
        removeMissionEventHandler ["Draw3D", _mehID];
    };

    _values params ["_target"];
    [QEGVAR(common,transferOwnership), [_entities, _target]] call CBA_fnc_serverEvent;
}, {
    params ["", "_args"];
    _args params ["", "_mehID"];
    if (_mehID > 0) then {
        removeMissionEventHandler ["Draw3D", _mehID];
    };
}, [_entities, _mehID]] call EFUNC(dialog,create);
