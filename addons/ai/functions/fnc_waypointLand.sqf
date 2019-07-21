#include "script_component.hpp"
/*
 * Author: Bohemia Interactive
 * Scripted waypoint that makes a group land at the waypoint's position.
 * Edited to improve AI behaviour and landing consistency.
 *
 * Arguments:
 * 0: Group <GROUP>
 * 1: Waypoint Position <ARRAY>
 *
 * Return Value:
 * Waypoint Finished <BOOL>
 *
 * Example:
 * [group, [0, 0, 0]] call zen_ai_fnc_waypointLand
 *
 * Public: No
 */

params ["_group", "_waypointPosition"];

private _waypoint = [_group, currentWaypoint _group];
_waypoint setWaypointDescription localize "STR_A3_CfgWaypoints_Land";

// Create an invisible helipad at the waypoint's position
// AI tend to land better if there is a helipad nearby
private _helipad = _group getVariable QGVAR(helipad);

if (isNil "_helipad") then {
    _helipad = "Land_HelipadEmpty_F" createVehicleLocal [0, 0, 0];
    _group setVariable [QGVAR(helipad), _helipad];
};

_helipad setPos _waypointPosition;

// Increase the courage level of the group
_group allowFleeing 0;

private _vehsMove = [];
private _vehsLand = [];

waitUntil {
    private _countReady = 0;
    private _vehsGroup = [];

    // Check state of group members
    {
        private _vehicle = vehicle _x;

        if (_x == effectiveCommander _x) then {
            if !(_vehicle in _vehsMove) then {
                // Increase the pilot's skill level, better flying
                driver _vehicle setSkill 1;

                // Move to landing position
                _vehicle doMove _waypointPosition;
                _vehsMove pushBack _vehicle;
            } else {
                if (isTouchingGround _vehicle) then {
                    // Ready, keep engine running
                    _vehicle engineOn true;
                    _countReady = _countReady + 1;
                } else {
                    if (unitReady _vehicle && {!(_vehicle in _vehsLand)}) then {
                        // Start landing
                        _vehicle land "LAND";
                        _vehsLand pushBack _vehicle;
                    };
                };
            };

            _vehsGroup pushBack _vehicle;
        };
    } forEach units _group;

    // Remove vehicles which are no longer in the group
    _vehsMove = _vehsMove select {_x in _vehsGroup};
    _vehsLand = _vehsLand select {_x in _vehsGroup};

    sleep 1;
    count _vehsGroup == _countReady
};

// Delete the created helipad
deleteVehicle _helipad;
_group setVariable [QGVAR(helipad), nil];

true
