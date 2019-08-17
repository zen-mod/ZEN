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

    [QGVAR(moduleCreateTeleporter), LINKFUNC(moduleCreateTeleporterServer)] call CBA_fnc_addEventHandler;
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

[QGVAR(fireArtillery), {
    params ["_unit", "_position", "_spread", "_ammo", "_rounds"];

    // For small spread values, use doArtilleryFire directly to avoid delay
    // between firing caused by using doArtilleryFire one round at a time
    if (_spread <= 10) exitWith {
        _unit doArtilleryFire [_position, _ammo, _rounds];
    };

    [{
        params ["_unit", "_position", "_spread", "_ammo", "_rounds", "_fired"];

        if (unitReady _unit) then {
            _unit doArtilleryFire [[_position, _spread] call CBA_fnc_randPos, _ammo, 1];
            _this set [5, _fired + 1];
        };

        _fired >= _rounds || {!alive _unit} || {!alive gunner _unit}
    }, {}, [_unit, _position, _spread, _ammo, _rounds, 0]] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;

// Function needs to be spawned
[QGVAR(earthquake), {_this spawn BIS_fnc_earthquake}] call CBA_fnc_addEventHandler;
