#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create a new teleport location.
 *
 * Arguments:
 * 0: Teleporter <OBJECT>
 * 1: Position <ARRAY>
 * 2: Name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [objNull, [0, 0, 0], "Location"] call zen_modules_fnc_moduleCreateTeleporterServer
 *
 * Public: No
 */

params ["_object", "_position", "_name"];

// Create a flag pole object if an object wasn't given
if (isNull _object) then {
    _object = createVehicle ["FlagPole_F", _position, [], 0, "NONE"];
    [QEGVAR(common,addObjects), [[_object]]] call CBA_fnc_localEvent;
};

// Add teleport action to new teleporter object
private _jipID = [QGVAR(addTeleporterAction), _object] call CBA_fnc_globalEventJIP;
[_jipID, _object] call CBA_fnc_removeGlobalEventJIP;

// Add EH to remove object from the teleporters list if it is deleted
_object addEventHandler ["Deleted", {
    params ["_object"];

    private _index = GVAR(teleporters) findIf {
        _object isEqualTo (_x select 0);
    };

    if (_index != -1) then {
        GVAR(teleporters) deleteAt _index;
        publicVariable QGVAR(teleporters);
    };
}];

// Add new teleport location and broadcast the updated list
GVAR(teleporters) pushBack [_object, _name];
publicVariable QGVAR(teleporters);
