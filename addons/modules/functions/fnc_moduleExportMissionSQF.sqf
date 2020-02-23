#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to export mission SQF.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleExportMissionSQF
 *
 * Public: No
 */

params ["_logic"];

private _position = getPosATL _logic;
deleteVehicle _logic;

[LSTRING(ExportMissionSQF), [
    [
        "COMBO",
        ELSTRING(common,Radius_Units),
        [
            [100, 250, 500, 1000, 2500, 5000, 10000, -1],
            ["100", "250", "500", "1000", "2500", "5000", "10000", LSTRING(EntireMission)],
            7
        ]
    ],
    [
        "TOOLBOX:YESNO",
        LSTRING(IncludeMarkers),
        false
    ]
], {
    params ["_values", "_position"];
    _values params ["_radius", "_includeMarkers"];

    private _missionSQF = [_position, _radius, true, _includeMarkers] call EFUNC(common,exportMissionSQF);

    [EFUNC(common,exportText), [LSTRING(ExportMissionSQF), _missionSQF, "EtelkaMonospacePro", 0.7]] call CBA_fnc_execNextFrame;
}, {}, _position] call EFUNC(dialog,create);
