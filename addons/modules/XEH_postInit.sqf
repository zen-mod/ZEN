#include "script_component.hpp"

if (isServer) then {
    [QGVAR(moduleAmbientAnimStart), LINKFUNC(moduleAmbientAnimStart)] call CBA_fnc_addEventHandler;
    [QGVAR(moduleAmbientFlyby), LINKFUNC(moduleAmbientFlyby)] call CBA_fnc_addEventHandler;
    [QGVAR(moduleCAS), LINKFUNC(moduleCAS)] call CBA_fnc_addEventHandler;
    [QGVAR(moduleEditableObjects), LINKFUNC(moduleEditableObjects)] call CBA_fnc_addEventHandler;
    [QGVAR(moduleSpawnReinforcements), LINKFUNC(moduleSpawnReinforcements)] call CBA_fnc_addEventHandler;

    // Public variable to track created teleporter objects
    missionNamespace setVariable [QGVAR(teleporters), [], true];

    [QGVAR(moduleCreateTeleporter), LINKFUNC(moduleCreateTeleporterServer)] call CBA_fnc_addEventHandler;

    [QGVAR(hideTerrainObjects), {
        params ["_position", "_objectTypes", "_radius", "_hide"];

        {
            _x hideObjectGlobal _hide;
        } forEach nearestTerrainObjects [_position, _objectTypes, _radius];
    }] call CBA_fnc_addEventHandler;
};

[QGVAR(addIntelAction), LINKFUNC(addIntelAction)] call CBA_fnc_addEventHandler;
[QGVAR(addTeleporterAction), LINKFUNC(addTeleporterAction)] call CBA_fnc_addEventHandler;
[QGVAR(moduleEffectFire), LINKFUNC(moduleEffectFireLocal)] call CBA_fnc_addEventHandler;
[QGVAR(moduleNuke), LINKFUNC(moduleNukeLocal)] call CBA_fnc_addEventHandler;

[QGVAR(sayMessage), BIS_fnc_sayMessage] call CBA_fnc_addEventHandler;
[QGVAR(carrierInit), BIS_fnc_Carrier01Init] call CBA_fnc_addEventHandler;
[QGVAR(destroyerInit), BIS_fnc_Destroyer01Init] call CBA_fnc_addEventHandler;
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
    params ["_forced", "_overcast", "_rain", "_lightning", "_rainbow", "_waves", "_wind", "_gusts", "_fog"];

    0 setOvercast _overcast;
    0 setLightnings _lightning;
    0 setRainbow _rainbow;
    0 setWaves _waves;
    0 setGusts _gusts;

    if (isServer) then {
        0 setRain _rain;
        0 setFog _fog;
        setWind _wind;

        if (_forced) then {
            forceWeatherChange;
        };
    };
}] call CBA_fnc_addEventHandler;

[QGVAR(addIntel), {
    params ["_title", "_text"];

    if !(player diarySubjectExists QGVAR(intel)) then {
        player createDiarySubject [QGVAR(intel), localize "str_disp_intel_title"];
    };

    player createDiaryRecord [QGVAR(intel), [_title, _text]];
}] call CBA_fnc_addEventHandler;

[QGVAR(teleportOutOfVehicle), {
    params ["_unit", "_position"];

    moveOut _unit;

    [{
        params ["_unit", "_position"];
        _unit setVelocity [0, 0, 0];
        _unit setVehiclePosition [_position, [], 0, "NONE"];
    }, _this] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

[QGVAR(setRotation), {
    params ["_object", "_pitch", "_roll", "_yaw"];

    _object setDir _yaw;
    [_object, _pitch, _roll] call BIS_fnc_setPitchBank;
}] call CBA_fnc_addEventHandler;

[QGVAR(moveToGunner), {
    params ["_unit", "_vehicle"];

    _unit assignAsGunner _vehicle;
    [_unit] orderGetIn true;
}] call CBA_fnc_addEventHandler;
