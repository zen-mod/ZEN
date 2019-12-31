#include "script_component.hpp"

[QGVAR(setSensors), {
    params ["_vehicle", "_sensors"];
    _sensors params ["_radarMode", "_reportTargets", "_receiveTargets", "_reportPosition"];

    _vehicle setVehicleRadar _radarMode;
    _vehicle setVehicleReportRemoteTargets _reportTargets;
    _vehicle setVehicleReceiveRemoteTargets _receiveTargets;
    _vehicle setVehicleReportOwnPosition _reportPosition;
}] call CBA_fnc_addEventHandler;

[QGVAR(setSkills), {
    params ["_unit", "_skills"];

    {
        _unit setSkill [_x, _skills select _forEachIndex];
    } forEach [
        "aimingAccuracy",
        "aimingSpeed",
        "aimingShake",
        "commanding",
        "courage",
        "spotDistance",
        "spotTime",
        "reloadSpeed"
    ];
}] call CBA_fnc_addEventHandler;

[QGVAR(setAllHitPointsDamage), {
    params ["_vehicle", "_damageValues"];

    {
        _vehicle setHitIndex [_forEachIndex, _x, false];
    } forEach _damageValues;
}] call CBA_fnc_addEventHandler;
