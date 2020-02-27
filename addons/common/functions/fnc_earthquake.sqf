#include "script_component.hpp"
/*
 * Author: mharis001
 * Creates an earthquake effect (blur, camera shake, sound).
 * If an earthquake is already active, this earthquake will take place after it finishes.
 * Unscheduled equivalent of BIS_fnc_earthquake.
 *
 * Arguments:
 * 0: Intensity (0..3) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [2] call zen_common_fnc_earthquake
 *
 * Public: No
 */

#define INITIAL_DELAY 1

if (canSuspend) exitWith {
    [FUNC(earthquake), _this] call CBA_fnc_directCall;
};

if (!hasInterface) exitWith {};

params [["_intensity", 0, [0]]];

if (isNil QGVAR(earthquakeActive)) then {
    GVAR(earthquakeActive) = false;
};

// If an earthquake is already active, wait until it finishes to start this one
if (GVAR(earthquakeActive)) exitWith {
    [{!GVAR(earthquakeActive)}, FUNC(earthquake), _this] call CBA_fnc_waitUntilAndExecute;
};

// Get earthquake parameters based on the given intensity
private _params = [
    [0.5, 13, 4, 200, "Earthquake_01"],
    [0.8, 20, 8,  50, "Earthquake_02"],
    [1.5, 20, 7,  40, "Earthquake_03"],
    [2.1, 20, 6,  30, "Earthquake_04"]
] select (0 max _intensity min 3);

_params params ["_power", "_duration", "_compensation", "_frequency", "_sound"];

// Create the post process blur effect if it has not been created already
if (isNil QGVAR(ppEarthquake)) then {
    GVAR(ppEarthquake) = ppEffectCreate ["DynamicBlur", 942];
};

GVAR(ppEarthquake) ppEffectEnable true;
GVAR(ppEarthquake) ppEffectAdjust [_power / 2];
GVAR(ppEarthquake) ppEffectCommit INITIAL_DELAY;

playSound _sound;

// Prevent other earthquakes from running while this one is active
GVAR(earthquakeActive) = true;

// Handle adjusting effects after necessary delays and allowing new earthquakes to occur
[{
    params ["_power", "_duration", "_compensation", "_frequency"];

    enableCamShake true;
    addCamShake [_power, _duration, _frequency];

    GVAR(ppEarthquake) ppEffectAdjust [0];
    GVAR(ppEarthquake) ppEffectCommit (_duration - _compensation);

    [{
        GVAR(ppEarthquake) ppEffectEnable false;
        GVAR(earthquakeActive) = false;
    }, [], _duration] call CBA_fnc_waitAndExecute;
}, [_power, _duration, _compensation, _frequency], INITIAL_DELAY] call CBA_fnc_waitAndExecute;
