#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

#include "initSettings.sqf"

// Add inventory button to attribute display
[
    "Object",
    "STR_A3_Gear1",
    {
        [_entity] call FUNC(configure);
    },
    {
        GVAR(enableInventory) && {alive _entity} && {maxLoad _entity > 0} && {!(_entity isKindOf "CAManBase")}
    }
] call EFUNC(attributes,addButton);

ADDON = true;
