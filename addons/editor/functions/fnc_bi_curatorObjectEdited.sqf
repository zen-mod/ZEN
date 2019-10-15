#include "script_component.hpp"
/*
 * Author: Bohemia Interactive, mharis001
 * Handles editing of an object by Zeus.
 * Edited to add handling for vehicle in vehicle cargo
 * and provide control over jet flyby sounds.
 *
 * Arguments:
 * 0: Curator (not used) <OBJECT>
 * 1: Edited Object <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_curator, _object] call BIS_fnc_curatorObjectEdited
 *
 * Public: No
 */

#define PARACHUTE_VAR "BIS_fnc_curatorObjectEdited_para"
#define PARACHUTE_HEIGHT 20
#define PARACHUTE_SOUND_TIMEOUT 10

params ["", "_object"];

// Handle attaching/detaching curatorCanAttach enabled objects
_object call BIS_fnc_curatorAttachObject;

// Delete current parachute if it exists
deleteVehicle (_object getVariable [PARACHUTE_VAR, objNull]);

// Handle slingloading in vehicle in vehicle transport
curatorMouseOver params ["_type", "_entity"];

if (_type == "OBJECT") exitWith {
    private _fnc_moveToGroundLevel = {
        params ["_object"];

        private _position = getPosATL _entity;
        _position set [2, 0];

        _object setVehiclePosition [_position, [], 0, "NONE"];
    };

    // Unload vehicle cargo if hovered object is transport vehicle
    if (isVehicleCargo _object == _entity) exitWith {
        objNull setVehicleCargo _object;
    };

    // Detach slingloaded object if hovered object is transport vehicle
    if (ropeAttachedTo _object == _entity) exitWith {
        _entity setSlingLoad objNull;

        [_object] call _fnc_moveToGroundLevel;
    };

    // Load object into hovered object as vehicle cargo if possible
    if (_entity canVehicleCargo _object select 0) exitWith {
        _entity setVehicleCargo _object;
    };

    // Slingload object from hovered object if possible
    if (_entity canSlingLoad _object) exitWith {
        // Detach from transport vehicle if the object is already slingloaded
        private _transportVehicle = ropeAttachedTo _object;

        if (!isNull _transportVehicle) then {
            _transportVehicle setSlingLoad objNull;
        };

        // Detach object if it is currently attached
        if (!isNull attachedTo _object) then {
            detach _object;
        };

        // Move the hovered object's slingloaded vehicle to the ground if needed
        [getSlingLoad _entity] call _fnc_moveToGroundLevel;

        // Move object into correct position before slingloading
        _object setPos (_entity modelToWorld [0, 0, -15]);
        _entity setSlingLoad _object;
    };
};

// Detach from slingload if the object was edited while slingloaded
private _transportVehicle = ropeAttachedTo _object;

if (!isNull _transportVehicle) then {
    _transportVehicle setSlingLoad objNull;
};

// Create a parachute for the object if it was moved high enough
if (alive _object && {simulationEnabled _object} && {getPos _object select 2 > PARACHUTE_HEIGHT}) then {
    private _fnc_createParachute = {
        params ["_object", "_parachuteType", "_attachPos"];

        private _parachute = createVehicle [_parachuteType, _object, [], 0, "NONE"];
        _parachute setDir getDir _object;
        _parachute setVelocity [0, 0, -1];

        if (isNil "_attachPos") then {
            [QEGVAR(common,moveInDriver), [_object, _parachute], _object] call CBA_fnc_targetEvent;
        } else {
            _object attachTo [_parachute, _attachPos];
        };

        _object setVariable [PARACHUTE_VAR, _parachute, true];

        // Play jet flyby sound to warn players about parachutes if enabled
        if (GVAR(parachuteSounds) && {CBA_missionTime >= missionNamespace getVariable [QGVAR(parachuteSoundTime), 0]}) then {
            [QEGVAR(common,say3D), [_parachute, selectRandom ["BattlefieldJet1", "BattlefieldJet2"]]] call CBA_fnc_globalEvent;
            missionNamespace setVariable [QGVAR(parachuteSoundTime), CBA_missionTime + PARACHUTE_SOUND_TIMEOUT];
        };
    };

    // Different parachute type and attachment positions based on the object
    (_object call BIS_fnc_objectType) params ["_objectCategory", "_objectType"];

    if (_objectCategory == "Object" && {_objectType == "AmmoBox"}) exitWith {
        [_object, "B_Parachute_02_F", [0, 0, 1]] call _fnc_createParachute;
    };

    if (_objectCategory in ["Vehicle", "VehicleAutonomous"] && {_objectType in ["Car", "Motorcycle", "Ship", "Submarine", "TrackedAPC", "Tank", "WheeledAPC"]}) exitWith {
        [_object, "B_Parachute_02_F", [0, 0, abs (boundingBox _object select 0 select 2)]] call _fnc_createParachute;
    };

    if (_objectCategory == "Soldier") exitWith {
        [_object, "Steerable_Parachute_F"] call _fnc_createParachute;
    };
};
