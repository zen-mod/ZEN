#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(aceMedical) = isClass (configFile >> "CfgPatches" >> "ace_medical");
GVAR(aceMedicalTreatment) = isClass (configFile >> "CfgPatches" >> "ace_medical_treatment");

GVAR(forceFireCurators) = [];
GVAR(selectPositionActive) = false;

GVAR(colorActiveElements) = ["IGUI", "TEXT_RGB"] call BIS_fnc_displayColorGet;
GVAR(hintEHID) = -1;
GVAR(hintElements) = [];

// Handling for running code after settings are initialized
GVAR(settingsInitialized) = false;
GVAR(runAfterSettingsInit) = [];

["CBA_settingsInitialized", {
    GVAR(settingsInitialized) = true;

    {
        _x params ["_function", "_args"];
        _args call _function;
    } forEach GVAR(runAfterSettingsInit);

    GVAR(runAfterSettingsInit) = nil;
}] call CBA_fnc_addEventHandler;

#include "initSettings.sqf"

ADDON = true;
