#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(mousePos) = [0, 0];

GVAR(aceMedical) = isClass (configFile >> "CfgPatches" >> "ace_medical");
GVAR(aceMedicalTreatment) = isClass (configFile >> "CfgPatches" >> "ace_medical_treatment");

GVAR(selectPositionActive) = false;

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

#include "initSettings.inc.sqf"

ADDON = true;
