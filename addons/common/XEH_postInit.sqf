#include "script_component.hpp"

// Fix BI Virtual Arsenal incorrectly changing Zeus camera position
[missionNamespace, "arsenalOpened", {
    {
        if (!isNull curatorCamera) then {
            GVAR(cameraData) = [getPosASL curatorCamera, [vectorDir curatorCamera, vectorUp curatorCamera]];
        };
    } call CBA_fnc_directCall;
}] call BIS_fnc_addScriptedEventHandler;

[missionNamespace, "arsenalClosed", {
    {
        if (!isNull curatorCamera) then {
            GVAR(cameraData) params ["_position", "_dirAndUp"];

            curatorCamera setPosASL _position;
            curatorCamera setVectorDirAndUp _dirAndUp;

            // Fix drawIcon3D icons being hidden after using arsenal
            cameraEffectEnableHUD true;
        };
    } call CBA_fnc_directCall;
}] call BIS_fnc_addScriptedEventHandler;

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

[QGVAR(say3D), {
    params ["_object", "_sound"];
    _object say3D _sound;
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

[QGVAR(setFormDir), {
    params ["_group", "_direction"];
    _group setFormDir _direction;
}] call CBA_fnc_addEventHandler;

[QGVAR(lockWP), {
    params ["_group", "_locked"];
    _group lockWP _locked;
}] call CBA_fnc_addEventHandler;

[QGVAR(setSkill), {
    params ["_unit", "_skill"];
    _unit setSkill _skill;
}] call CBA_fnc_addEventHandler;

[QGVAR(setUnitTrait), {
    params ["_unit", "_trait", "_value"];
    _unit setUnitTrait [_trait, _value];
}] call CBA_fnc_addEventHandler;

[QGVAR(enableAI), {
    params ["_unit", "_sections"];

    if (_sections isEqualType "") then {
        _sections = [_sections];
    };

    {
        _unit enableAI _x;
    } forEach _sections;
}] call CBA_fnc_addEventHandler;

[QGVAR(disableAI), {
    params ["_unit", "_sections"];

    if (_sections isEqualType "") then {
        _sections = [_sections];
    };

    {
        _unit disableAI _x;
    } forEach _sections;
}] call CBA_fnc_addEventHandler;

[QGVAR(doMove), {
    params ["_unit", "_position"];
    _unit setDestination [_position, "LEADER PLANNED", true];
    _unit doMove _position;
}] call CBA_fnc_addEventHandler;

[QGVAR(doWatch), {
    params ["_unit", "_target"];
    _unit doWatch _target;
}] call CBA_fnc_addEventHandler;

[QGVAR(enableGunLights), {
    params ["_unit", "_mode"];
    _unit enableGunLights _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(enableIRLasers), {
    params ["_unit", "_mode"];
    _unit enableIRLasers _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(moveInDriver), {
    params ["_unit", "_vehicle"];
    _unit moveInDriver _vehicle;
}] call CBA_fnc_addEventHandler;

[QGVAR(unassignVehicle), {
    params ["_unit"];
    unassignVehicle _unit;
}] call CBA_fnc_addEventHandler;

[QGVAR(setCaptive), {
    params ["_unit", "_status"];
    _unit setCaptive _status;
}] call CBA_fnc_addEventHandler;

[QGVAR(engineOn), {
    params ["_vehicle", "_state"];
    _vehicle engineOn _state;
}] call CBA_fnc_addEventHandler;

[QGVAR(setPilotLight), {
    params ["_vehicle", "_lights"];
    _vehicle setPilotLight _lights;
}] call CBA_fnc_addEventHandler;

[QGVAR(setCollisionLight), {
    params ["_vehicle", "_lights"];
    _vehicle setCollisionLight _lights;
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

[QGVAR(setVectorUp), {
    params ["_object", "_vectorUp"];
    _object setVectorUp _vectorUp;
}] call CBA_fnc_addEventHandler;

[QGVAR(setVelocity), {
    params ["_object", "_velocity"];
    _object setVelocity _velocity;
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

[QGVAR(setAmmoOnPylon), {
    params ["_vehicle", "_pylon", "_ammoCount"];
    _vehicle setAmmoOnPylon [_pylon, _ammoCount];
}] call CBA_fnc_addEventHandler;

[QGVAR(doArtilleryFire), {
    params ["_unit", "_position", "_magazine", "_rounds"];
    _unit doArtilleryFire [_position, _magazine, _rounds];
}] call CBA_fnc_addEventHandler;

[QGVAR(setVehicleRadar), {
    params ["_vehicle", "_mode"];
    _vehicle setVehicleRadar _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setVehicleReportRemoteTargets), {
    params ["_vehicle", "_mode"];
    _vehicle setVehicleReportRemoteTargets _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setVehicleReceiveRemoteTargets), {
    params ["_vehicle", "_mode"];
    _vehicle setVehicleReceiveRemoteTargets _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(setVehicleReportOwnPosition), {
    params ["_vehicle", "_mode"];
    _vehicle setVehicleReportOwnPosition _mode;
}] call CBA_fnc_addEventHandler;

[QGVAR(initVehicle), BIS_fnc_initVehicle] call CBA_fnc_addEventHandler;

[QGVAR(addWeaponItem), {
    params ["_unit", "_weapon", "_item"];
    _unit addweaponItem [_weapon, _item];
}] call CBA_fnc_addEventHandler;

[QGVAR(setDate), {setDate _this}] call CBA_fnc_addEventHandler;

[QGVAR(setUnitIdentity), {
    params ["_unit", "_name", "_face", "_speaker", "_pitch", "_nameSound"];

    _unit setName _name;
    _unit setFace _face;
    _unit setSpeaker _speaker;
    _unit setPitch _pitch;
    _unit setNameSound _nameSound;
}] call CBA_fnc_addEventHandler;

[QGVAR(earthquake), LINKFUNC(earthquake)] call CBA_fnc_addEventHandler;
[QGVAR(fireArtillery), LINKFUNC(fireArtillery)] call CBA_fnc_addEventHandler;
[QGVAR(forceFire), LINKFUNC(forceFire)] call CBA_fnc_addEventHandler;
[QGVAR(setLampState), LINKFUNC(setLampState)] call CBA_fnc_addEventHandler;
[QGVAR(setMagazineAmmo), LINKFUNC(setMagazineAmmo)] call CBA_fnc_addEventHandler;
[QGVAR(setTurretAmmo), LINKFUNC(setTurretAmmo)] call CBA_fnc_addEventHandler;
[QGVAR(showMessage), LINKFUNC(showMessage)] call CBA_fnc_addEventHandler;

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

    {
        ["AllVehicles", "InitPost", {
            params ["_object"];

            if (_object getVariable [QGVAR(autoAddObject), GVAR(autoAddObjects)]) then {
                [{
                    {
                        _x addCuratorEditableObjects [[_this], true];
                    } forEach allCurators;
                }, _object] call CBA_fnc_execNextFrame;
            };
        }, true, [], true] call CBA_fnc_addClassEventHandler;

        ["ModuleCurator_F", "Init", {
            params ["_logic"];

            if (GVAR(autoAddObjects)) then {
                _logic addCuratorEditableObjects [allMissionObjects "AllVehicles", true];
            };
        }, true, [], false] call CBA_fnc_addClassEventHandler;
    } call FUNC(runAfterSettingsInit);

    [QGVAR(createZeus), LINKFUNC(createZeus)] call CBA_fnc_addEventHandler;
    [QGVAR(deserializeObjects), LINKFUNC(deserializeObjects)] call CBA_fnc_addEventHandler;
};
