#include "script_component.hpp"
/*
 * Author: mharis001
 * Zeus module function to create an earthquake.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_modules_fnc_moduleEarthquake
 *
 * Public: No
 */

params ["_logic"];

private _position = ASLToAGL getPosASL _logic;
deleteVehicle _logic;

[LSTRING(ModuleEarthquake), [
    ["SLIDER:RADIUS", LSTRING(ModuleEarthquake_Radius), [0, 5000, 200, 0, _position , [1, 0, 0, 0.7]]],
    ["TOOLBOX", LSTRING(ModuleEarthquake_Intensity), [0, 1, 4, [ELSTRING(common,VeryWeak), ELSTRING(common,Weak), ELSTRING(common,Medium), ELSTRING(common,Strong)]]],
    ["TOOLBOX:YESNO", LSTRING(ModuleEarthquake_Buildings), false]
], {
    params ["_dialogValues", "_position"];
    _dialogValues params ["_radius", "_intensity", "_destroyBuildings"];

    private _units = allPlayers select {_x distance _position < _radius};
    [QEGVAR(common,earthquake), _intensity, _units] call CBA_fnc_targetEvent;

    if (_destroyBuildings) then {
        private _buildings = _position nearObjects ["Building", _radius];

        // Buildings to destroy based on intensity: 6.25%, 12.5%, 25%, 50%
        private _countToDestroy = round (count _buildings * 2 ^ (_intensity - 3) / 2);

        for "_i" from 1 to _countToDestroy do {
            private _building = _buildings deleteAt floor random count _buildings;

            // Delay so buildings are not destroyed immediately or at the same time
            // Produces a more earthquake like effect
            [{_this setDamage 1}, _building, random 10] call CBA_fnc_waitAndExecute;
        };
    };
}, {}, _position] call EFUNC(dialog,create);
