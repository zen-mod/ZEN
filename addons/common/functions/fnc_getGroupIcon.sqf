#include "script_component.hpp"
/*
 * Author: kymckay, mharis001
 * Returns the file path of an appropriate icon for the given group.
 *
 * Arguments:
 * 0: Group <GROUP>
 *
 * Return Value:
 * Icon File Path <STRING>
 *
 * Example:
 * [_group] call zen_common_fnc_getGroupIcon
 *
 * Public: No
 */

params [["_group", grpNull, [grpNull]]];

private _side = side _group;
private _leader = leader _group;

private _iconType = call {
    // Empty groups are unknown
    if (isNull _leader) exitWith {
        "unknown"
    };

    // Civilians are easy, just check leader's vehicle (unlikely group is large)
    if (_side == civilian) exitWith {
        if (isNull objectParent _leader) exitWith {
            "unknown"
        };

        private _vehicle = vehicle _leader;

        // Check more common cases first
        switch (true) do {
            case (_vehicle isKindOf "LandVehicle"): {
                "car"
            };
            // Plane inherits Air, check first
            case (_vehicle isKindOf "Plane"): {
                "plane"
            };
            case (_vehicle isKindOf "Air"): {
                "air"
            };
            case (_vehicle isKindOf "Ship"): {
                "ship"
            };
            default {
                "unknown"
            };
        };
    };

    // Otherwise, we need to handle military groups in more detail
    private _units = units _group;
    private _vehicles = (_units apply {vehicle _x}) - _units;

    // If at least 33% of the group is mounted, use most common vehicle
    if (count _vehicles >= 0.33 * count _units) exitWith {
        // Check the most likely cases first
        private _threshold = 0.5 * count _vehicles;

        switch (true) do {
            case ("Car" countType _vehicles >= _threshold): {
                "motor_inf"
            };
            // APC inherits Tank, check first
            case ("APC" countType _vehicles >= _threshold): {
                "mech_inf"
            };
            // MBT_01_arty_base_F inherits Tank, check first
            // Unfortunately no common arty class to check
            case ("MBT_01_arty_base_F" countType _vehicles >= _threshold);
            case ("MBT_02_arty_base_F" countType _vehicles >= _threshold);
            case ({getNumber (configOf _x >> "artilleryScanner") == 1} count _vehicles >= _threshold): {
                "art"
            };
            case ("Tank" countType _vehicles >= _threshold): {
                "armor"
            };
            // UAV inherits Plane, check first
            case ("UAV" countType _vehicles >= _threshold): {
                "uav"
            };
            // Plane inherits Air, check first
            case ("Plane" countType _vehicles >= _threshold): {
                "plane"
            };
            case ("Air" countType _vehicles >= _threshold): {
                "air"
            };
            case ("Ship" countType _vehicles >= _threshold): {
                "naval"
            };
            // StaticMortar inherits StaticWeapon, check first
            case ("StaticMortar" countType _vehicles >= _threshold): {
                "mortar"
            };
            case ("StaticWeapon" countType _vehicles >= _threshold): {
                "installation"
            };
            // If it reaches here then it's a mixed group of vehicles
            default {
                "unknown"
            };
        };
    };

    // Check leader for medic/engineer/etc, otherwise just default to infantry
    private _isMedic = _leader getUnitTrait "medic";
    private _isEngineer = _leader getUnitTrait "engineer";

    switch (true) do {
        case (_isMedic && {_isEngineer}): {
            "support"
        };
        case (_isMedic): {
            "med"
        };
        case (_isEngineer): {
            "maint"
        };
        default {
            "inf"
        };
    };
};

private _iconPrefix = switch (_side) do {
    case west: {
        "b_"
    };
    case east: {
        "o_"
    };
    case independent: {
        "n_"
    };
    default {
        "c_"
    };
};

getText (configFile >> "CfgMarkers" >> _iconPrefix + _iconType >> "icon")
