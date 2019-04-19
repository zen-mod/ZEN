#include "script_component.hpp"

[QGVAR(execute), {
    params ["_code", "_args"];
    _args call _code;
}] call CBA_fnc_addEventHandler;

[QGVAR(hint), {
    params ["_message"];
    hint _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(globalChat), {
    params ["_unit", "_message"];
    _unit globalChat _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(sideChat), {
    params ["_unit", "_message"];
    _unit sideChat _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(commandChat), {
    params ["_unit", "_message"];
    _unit commandChat _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(groupChat), {
    params ["_unit", "_message"];
    _unit groupChat _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(vehicleChat), {
    params ["_unit", "_message"];
    _unit vehicleChat _message;
}] call CBA_fnc_addEventHandler;

[QGVAR(setUnitPos), {
    params ["_unit", "_mode"];
    _unit setUnitPos _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setBehaviour), {
    params ["_group", "_behaviour"];
    _group setBehaviour _behaviour;
}] call CBA_fnc_addEventHandler;

[QGVAR(setCombatMode), {
    params ["_group", "_combatMode"];
    _group setCombatMode _combatMode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setSpeedMode), {
    params ["_group", "_mode"];
    _group setSpeedMode _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setFormation), {
    params ["_group", "_formation"];
    _group setFormation _formation;
}] call CBA_fnc_addEventHandler;

[QGVAR(setSkill), {
    params ["_unit", "_skill"];
    _unit setSkill _skill;
}] call CBA_fnc_addEventHandler;

[QGVAR(enableAI), {
    params ["_unit", "_section"];
    _unit enableAI _section;
}] call CBA_fnc_addEventHandler;

[QGVAR(disableAI), {
    params ["_unit", "_section"];
    _unit disableAI _section;
}] call CBA_fnc_addEventHandler;

[QGVAR(flyInHeight), {
    params ["_aircraft", "_height"];
    _aircraft flyInHeight _height;
}] call CBA_fnc_addEventHandler;

[QGVAR(setConvoySeparation), {
    params ["_vehicle", "_distance"];
    _vehicle setConvoySeparation _distance;
}] call CBA_fnc_addEventHandler;

[QGVAR(limitSpeed), {
    params ["_vehicle", "_speed"];
    _vehicle limitSpeed _speed;
}] call CBA_fnc_addEventHandler;

[QGVAR(forceFollowRoad), {
    params ["_vehicle", "_mode"];
    _vehicle forceFollowRoad _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setName), {
    params ["_unit", "_name"];
    _unit setName _name;
}] call CBA_fnc_addEventHandler;

[QGVAR(setDir), {
    params ["_object", "_direction"];
    _object setDir _direction;
}] call CBA_fnc_addEventHandler;

[QGVAR(setFuel), {
    params ["_vehicle", "_fuel"];
    _vehicle setFuel _fuel;
}] call CBA_fnc_addEventHandler;

[QGVAR(allowDamage), {
    params ["_object", "_allow"];
    _object allowDamage _allow;
}] call CBA_fnc_addEventHandler;

[QGVAR(lock), {
    params ["_vehicle", "_state"];
    _vehicle lock _state;
}] call CBA_fnc_addEventHandler;

[QGVAR(playMoveNow), {
    params ["_unit", "_animation"];
    _unit playMoveNow _animation;
}] call CBA_fnc_addEventHandler;

[QGVAR(switchMove), {
    params ["_unit", "_animation"];
    _unit switchMove _animation;
}] call CBA_fnc_addEventHandler;

[QGVAR(setPlateNumber), {
    params ["_vehicle", "_string"];
    _vehicle setPlateNumber _string;
}] call CBA_fnc_addEventHandler;

if (isServer) then {
    [QGVAR(hideObjectGlobal), {
        params ["_object", "_hide"];
        _object hideObjectGlobal _hide;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(enableSimulationGlobal), {
        params ["_object", "_enable"];
        _object enableSimulationGlobal _enable;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(setFriend), {
        params ["_side1", "_side2", "_value"];
        _side1 setFriend [_side2, _value];
    }] call CBA_fnc_addEventHandler;

    [QGVAR(setWaypointFormation), {
        params ["_waypoint", "_formation"];
        _waypoint setWaypointFormation _formation;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(setWaypointBehaviour), {
        params ["_waypoint", "_behaviour"];
        _waypoint setWaypointBehaviour _behaviour;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(setWaypointCombatMode), {
        params ["_waypoint", "_combatMode"];
        _waypoint setWaypointCombatMode _combatMode;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(setWaypointSpeed), {
        params ["_waypoint", "_speedMode"];
        _waypoint setWaypointSpeed _speedMode;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(setDate), {
        params ["_date"];
        setDate _date;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(addObjects), {
        params ["_objects", ["_curator", objNull]];

        if (!isNull _curator) exitWith {
            _curator addCuratorEditableObjects [_objects, true];
        };

        {
            _x addCuratorEditableObjects [_objects, true];
        } forEach allCurators;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(removeObjects), {
        params ["_objects", ["_curator", objNull]];

        if (!isNull _curator) exitWith {
            _curator removeCuratorEditableObjects [_objects, true];
        };

        {
            _x removeCuratorEditableObjects [_objects, true];
        } forEach allCurators;
    }] call CBA_fnc_addEventHandler;
};

["CBA_settingsInitialized", {
    if (isServer && {GVAR(autoAddObjects)}) then {
        ["AllVehicles", "InitPost", FUNC(addObjectToCurators), true, [], true] call CBA_fnc_addClassEventHandler;
    };
}] call CBA_fnc_addEventHandler;
