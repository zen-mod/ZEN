#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(aceMedical) = isClass (configFile >> "CfgPatches" >> "ace_medical");
GVAR(aceMedicalTreatment) = isClass (configFile >> "CfgPatches" >> "ace_medical_treatment");

GVAR(selectPositionActive) = false;

#include "initSettings.sqf"

ADDON = true;
