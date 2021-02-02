#include "script_component.hpp"
/*
 * Author: CreepPork
 * Zeus module function to create a new Spectrum Device beacon (a signal).
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_spectrum_fnc_moduleSpectrumBeacon
 *
 * Public: No
 */

params ["_logic"];

[
    "Spectrum Device Beacon",
    [
        ["SLIDER", "Frequency (MHz)", [78, 500, 140, 0]],
        ["SLIDER", "Range (m)", [0, 5000, 1000, 0]]
    ],
    {
        params ["_values", "_logic"];
        _values params ["_frequency", "_range"];

        _logic setVariable [QGVAR(frequency), _frequency];
        _logic setVariable [QGVAR(range), _range];

        // Stop calculation on this beacon when deleted and remove it from the device
        _logic addEventHandler ["Deleted", {
            params ["_logic"];

            LOG("Beacon was deleted");
            [_logic] call FUNC(removeBeacon);
        }];

        // Update the beacon position when the module is moved
        _logic addEventHandler ["CuratorObjectEdited", {
            params ["_curator", "_logic"];
            [_logic] call FUNC(updateBeacon);
        }];

        [_logic, _frequency, _range] call FUNC(addBeacon);
    },
    {},
    [_logic]
] call EFUNC(dialog,create);

