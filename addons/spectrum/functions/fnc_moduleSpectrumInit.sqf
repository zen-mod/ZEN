#include "script_component.hpp"
/*
 * Author: CreepPork
 * Zeus module function to setup the Spectrum Device user interface.
 *
 * Arguments:
 * 0: Logic <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [LOGIC] call zen_spectrum_fnc_moduleSpectrumInit
 *
 * Public: No
 */

/**
    TODO:

    - Create a editor subcategory for Spectrum Device
    - Make certain signals only be picked up by a certain antennae
        - Transform this module to only pick the antennae type (https://gyazo.com/096e7dabce50b1943467b0fcfd31e10c)
            - This will auto-set the allowed frequencies
    - Probably, trigger on weapon switch event (sidearm selected) and check if it is the Spectrum Device (only when init completed in ZEN)
        - If is, then check if the antennae equipped matches the selected type in the init module
        - This check must only happen when the player is aiming down sights (ADS), because just taking the antennae out of his inventory or
            adjusting it in Arsenal, might throw wrong messages.
            - Also, might show up a full-screen error message (prompt) so the user knows (because you cannot change the spectrum device monitor)
            - After confirmation of the error dialog, it must holster the Spectrum Device.
        - Another check must be added that checks if another player is not using the Spectrum Device (can ignore Zeus'es?) (also ADS)
            - If another player has the spectrum device open, show a error message and holster the device (because of global variables for the Device UI)
    - Create a Spectrum Device Beacon module:
        - Pick a sound (ripped from Contact DLC sounds) (once selected it will play the sound so the Zeus knows what it sounds like)
            - Sound when hovering near the frequency
            - Sound when the frequency is selected
            - Sound when getting closer to the source of the frequency
        - Maybe a descriptive name for the Zeus? (Could append that name to the module itself?)
        - By what antennae can be picked up
        - And the frequency in which it will operate
        - How far this beacon can be picked up by Spectrum Devices
    - Implement local function that uses the Spectrum's API to update the values for the current user of the Spectrum Device
        - This would calculate the distance to the ZEN's Spectrum Beacon module and if the parameters allow it, display it in the Spectrum Device
    - Test the whole implementation with JIPs

 */

params ["_logic"];

deleteVehicle _logic;

[
    "Spectrum Device Initialization",
    [
        ["SLIDER", "Minimum Frequency (MHz)", [78, 500, 140, 0]],
        ["SLIDER", "Maximum Frequency (MHz)", [78, 500, 145, 0]],
        ["SLIDER", "Minimum Sensitivity (-dBm)", [1, 100, 10, 0]],
        ["SLIDER", "Maximum Sensitivity (-dBm)", [1, 100, 60, 0]],
        ["SLIDER", "Selected Frequency (MHz)", [78, 500, 143, 2]]
    ],
    {
        params ["_values"];
        _values params ["_minFrequency", "_maxFrequency", "_minSensitivity", "_maxSensitivity", "_selectedFrequency"];

        // Check if selected frequency is in range
        if (_minFrequency > _selectedFrequency || _selectedFrequency > _maxFrequency) exitWith {
            ["Selected frequency must be in range"] call EFUNC(common,showMessage);
        };

        // Spectrum device expects the sensitivity to be negative
        _minSensitivity = _minSensitivity * -1;
        _maxSensitivity = _maxSensitivity * -1;

        // Calculate the selected frequency maximum
        private _maxSelectedFrequency = _selectedFrequency + 0.3;

        // Set frequency
        missionNamespace setVariable ["#EM_FMin", _minFrequency];
        missionNamespace setVariable ["#EM_FMax", _maxFrequency];

        // Set sensitivity
        missionNamespace setVariable ["#EM_SMin", _minSensitivity];
        missionNamespace setVariable ["#EM_SMax", _maxSensitivity];

        // Selected frequency
        missionNamespace setVariable ["#EM_SelMin", _selectedFrequency];
        missionNamespace setVariable ["#EM_SelMax", _maxSelectedFrequency];

        // Reset behaviour
        missionNamespace setVariable ["#EM_Progress", 0];
        missionNamespace setVariable ["#EM_Transmit", false];

        // Clear all Spectrum signals
        missionNamespace setVariable ["#EM_Values", []];
    }
] call EFUNC(dialog,create);
