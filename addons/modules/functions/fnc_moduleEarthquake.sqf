/*
 * Author: mharis001
 * Zeus module function to create an earthquake.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 * 1: Radius <NUMBER>
 * 2: Intensity <NUMBER>
 * 3: Destroy buildings <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC, 1000, 2, true] call zen_modules_fnc_moduleEarthquake
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_logic", "_radius", "_intensity", "_destroyBuildings"];

private _units = allPlayers select {_x distance _logic < _radius};
[QGVAR(earthquake), _intensity, _units] call CBA_fnc_targetEvent;

if (_destroyBuildings) then {
    private _buildings = _logic nearObjects ["Building", _radius];

    // Buildings to destroy based on intensity: 6.25%, 12.5%, 25%, 50%
    private _countToDestroy = round (count _buildings * 2 ^ (_intensity - 3) / 2);

    for "_i" from 1 to _countToDestroy do {
        private _building = _buildings deleteAt floor random count _buildings;

        // Delay so buildings are not destroyed immediately or at the same time
        // Produces a more earthquake like effect
        [{_this setDamage 1}, _building, random 10] call CBA_fnc_waitAndExecute;
    };
};
