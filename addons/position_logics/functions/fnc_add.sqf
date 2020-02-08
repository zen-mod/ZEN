#include "script_component.hpp"
/*
 * Author: mharis001
 * Adds the given logic to its corresponding position logic list.
 * Initializes the position logic by applying its name, adding it to
 * all curators, and handling its cleanup if it is deleted.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Name <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_logic, _name] call zen_position_logics_fnc_add
 *
 * Public: No
 */

params [["_logic", objNull, [objNull]], ["_name", "", [""]]];

if (isServer) then {
    private _type = typeOf _logic;

    private _listVarName = VAR_LIST(_type);
    private _list = missionNamespace getVariable [_listVarName, []];

    // Exit if the logic has already been added to the list
    if (_logic in _list) exitWith {};

    // Increment the corresponding next ID, for returning unique default names
    private _nextIDVarName = VAR_NEXTID(_type);
    private _nextID = missionNamespace getVariable [_nextIDVarName, 0];

    _nextID = _nextID + 1;

    // Apply the given name to the logic
    private _jipID = [QEGVAR(common,setName), [_logic, _name]] call CBA_fnc_globalEventJIP;
    [_jipID, _logic] call CBA_fnc_removeGlobalEventJIP;

    // Make the logic editable for all curators
    [QEGVAR(common,addObjects), [[_logic]]] call CBA_fnc_localEvent;

    // Disable attributes for the logic
    _logic setVariable [QEGVAR(attributes,disabled), true, true];

    // Add event to remove the logic from the list if it is deleted
    // Also, handle the cleanup of any attached objects
    _logic addEventHandler ["Deleted", {
        params ["_logic"];

        private _listVarName = VAR_LIST(typeOf _logic);
        private _list = missionNamespace getVariable [_listVarName, []];

        {
            if (_x getVariable [QGVAR(delete), false]) then {
                deleteVehicle _x;
            };
        } forEach attachedObjects _logic;

        _list deleteAt (_list find _logic);
        missionNamespace setVariable [_listVarName, _list, true];
    }];

    // Add the logic to its corresponding list and broadcast changes
    _list pushBack _logic;

    missionNamespace setVariable [_listVarName, _list, true];
    missionNamespace setVariable [_nextIDVarName, _nextID, true];
} else {
    // All position logic handling is done on the server
    [QGVAR(add), [_logic, _name]] call CBA_fnc_serverEvent;
};
