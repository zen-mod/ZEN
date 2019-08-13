#include "script_component.hpp"

if (isServer) then {
    [QGVAR(moduleAmbientAnimStart), FUNC(moduleAmbientAnimStart)] call CBA_fnc_addEventHandler;
    [QGVAR(moduleAmbientFlyby), FUNC(moduleAmbientFlyby)] call CBA_fnc_addEventHandler;
    [QGVAR(moduleCAS), FUNC(moduleCAS)] call CBA_fnc_addEventHandler;
    [QGVAR(moduleEditableObjects), FUNC(moduleEditableObjects)] call CBA_fnc_addEventHandler;

    // Public variable to track created target logics
    missionNamespace setVariable [QGVAR(targetLogics), [], true];

    // Public variable to track created teleporter objects
    missionNamespace setVariable [QGVAR(teleporters), [], true];

    [QGVAR(createTeleporter), {
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
    }] call CBA_fnc_addEventHandler;
};

[QGVAR(addTeleporterAction), LINKFUNC(addTeleporterAction)] call CBA_fnc_addEventHandler;

[QGVAR(sayMessage), BIS_fnc_sayMessage] call CBA_fnc_addEventHandler;
[QGVAR(carrierInit), BIS_fnc_Carrier01Init] call CBA_fnc_addEventHandler;
[QGVAR(destroyerInit), BIS_fnc_Destroyer01Init] call CBA_fnc_addEventHandler;
[QGVAR(moveToRespawnPosition), BIS_fnc_moveToRespawnPosition] call CBA_fnc_addEventHandler;
[QGVAR(taskPatrol), CBA_fnc_taskPatrol] call CBA_fnc_addEventHandler;

[QGVAR(autoSeekBehavior), {
    params ["_unit"];

    _unit setUnitPos "UP";
    _unit setSpeedMode "FULL";
    _unit setBehaviour "CARELESS";
    _unit setCombatMode "BLUE";
    _unit disableAI "TARGET";
    _unit disableAI "AUTOTARGET";
    _unit allowFleeing 0;
}] call CBA_fnc_addEventHandler;

[QGVAR(applyWeather), {
    params ["_overcast", "_rain", "_lightning", "_rainbow", "_waves", "_wind", "_gusts", "_fog"];

    0 setOvercast _overcast;
    0 setLightnings _lightning;
    0 setRainbow _rainbow;
    0 setWaves _waves;
    0 setGusts _gusts;

    if (isServer) then {
        0 setRain _rain;
        0 setFog _fog;
        setWind _wind;

        forceWeatherChange;
    };

}] call CBA_fnc_addEventHandler;

// Function needs to be spawned
[QGVAR(earthquake), {_this spawn BIS_fnc_earthquake}] call CBA_fnc_addEventHandler;
