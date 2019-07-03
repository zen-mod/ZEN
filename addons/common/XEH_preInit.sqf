#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(aceMedicalLoaded) = isClass (configFile >> "CfgPatches" >> "ace_medical");

#include "initSettings.sqf"

ADDON = true;
