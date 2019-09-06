#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(helperPos) = [0, 0, -1];
GVAR(camDistance) = 10;
GVAR(camPitch) = 15;
GVAR(camYaw) = -45;

[
    "Object",
    "STR_A3_Garage",
    {_entity call FUNC(openGarage)},
    {alive _entity && {_entity isKindOf "LandVehicle" || {_entity isKindOf "Air"} || {_entity isKindOf "Ship"}}},
    true
] call EFUNC(attributes,addButton);

ADDON = true;
