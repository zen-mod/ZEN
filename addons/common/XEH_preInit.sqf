#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(aceMedicalLoaded) = isClass (configFile >> "CfgPatches" >> "ace_medical");
// Detect next ACE update containing medical rewrite which will change medical functions
GVAR(aceMedicalTreatmentLoaded) = isClass (configFile >> "CfgPatches" >> "ace_medical_treatment");

#include "initSettings.sqf"

ADDON = true;
