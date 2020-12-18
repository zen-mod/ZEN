#include "script_component.hpp"

if (isServer) then {
    [QGVAR(setObjectStates), {
        params ["_object", "_states"];
        _states params ["_damage", "_simulation", "_hidden"];

        _object hideObjectGlobal _hidden;
        _object enableSimulationGlobal _simulation;
        [QEGVAR(common,allowDamage), [_object, _damage], _object] call CBA_fnc_targetEvent;
    }] call CBA_fnc_addEventHandler;

    [QGVAR(setVehicleRespawn), {
        params ["_vehicle", "_respawn"];

        [_vehicle, true] call BIS_fnc_moduleRespawnVehicle;

        if (_respawn != -1) then {
            [_vehicle, nil, nil, nil, BIS_fnc_curatorRespawn, _respawn] call BIS_fnc_moduleRespawnVehicle;
        };
    }] call CBA_fnc_addEventHandler;
};

[QGVAR(setAbilities), {
    params ["_unit", "_abilities"];

    {
        _unit enableAIFeature [_x, _abilities select _forEachIndex];
    } forEach AI_ABILITIES;
}] call CBA_fnc_addEventHandler;

[QGVAR(setTracers), {
    params ["_logic"];

    {
        deletevehicle _x;
    } forEach attachedObjects _logic;
    [_logic] call EFUNC(modules,moduleTracers);

    // changing multiple attributes at the same time can cause multiple gunners to spawn. Delete all but the last.
    [{
        params ["_logic"];
        private _gunners = attachedObjects _logic;
        if (count _gunners > 1) then {
            private _gunner = _logic getvariable ["bis_fnc_moduleTracers_gunner", objnull];
            {
                deletevehicle _x;
            } forEach (_gunners - [_gunner]);
        };
    }, {}, [_logic], 1] call CBA_fnc_waitUntilAndExecute;
}] call CBA_fnc_addEventHandler;
