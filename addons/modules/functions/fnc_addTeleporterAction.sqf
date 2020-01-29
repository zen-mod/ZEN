#include "script_component.hpp"
/*
 * Author: mharis001
 * Adds a teleporter action to the given object.
 *
 * Arguments:
 * 0: Teleporter <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [cursorObject] call zen_modules_fnc_addTeleporterAction
 *
 * Public: No
 */

params ["_object"];

private _actionID = _object addAction [
    "",
    {
        params ["_target"];

        private _names = [];
        private _objects = [];

        {
            _x params ["_object", "_name"];

            if (_object != _target) then {
                _names pushBack _name;
                _objects pushBack _object;
            };
        } forEach GVAR(teleporters);

        [ELSTRING(common,Teleport), [
            ["LIST", "str_dn_locations", [_objects, _names, 0], true]
        ], {
            params ["_values"];
            _values params ["_object"];

            // Exit if the object was deleted after opening the menu
            // Otherwise the unit will be teleported to [0, 0, 0]
            if (isNull _object) exitWith {};

            private _unit = call CBA_fnc_currentUnit;
            private _vehicle = vehicle _unit;

            // Teleport the vehicle of the unit if not on foot
            if (_vehicle != _unit) exitWith {
                private _position = getPosATL _object findEmptyPosition [5, 100, typeOf _vehicle];

                if (_position isEqualTo []) exitWith {
                    [LSTRING(NoTeleportPosition), true] call CBA_fnc_notify;
                };

                _vehicle setVehiclePosition [_position, [], 0, "NONE"];
            };

            // Attempt to move unit into the object if it is a vehicle
            if (_unit moveInAny _object) exitWith {};

            // Move unit near the object if the object is not a vehicle or is full
            _unit setVehiclePosition [_object, [], 0, "NONE"];
        }] call EFUNC(dialog,create);
    },
    nil,
    100,
    true,
    true,
    "",
    QUOTE(GVAR(teleporters) findIf {_x select 0 != _target} != -1),
    10
];

private _text = format ["<t color='#FFFFFF'>%1</t>", localize ELSTRING(common,Teleport)];
private _picture = format ["<img image='%1' size='1.75' /><br />%2", ICON_LOCATION, _text];
_object setUserActionText [_actionID, _text, "", _picture];
