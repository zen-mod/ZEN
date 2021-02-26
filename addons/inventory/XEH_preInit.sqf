#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Add inventory button to attribute display
[
    "Object",
    "STR_A3_Gear1",
    {
        [_entity] call FUNC(configure);
    },
    {
        alive _entity && {getNumber (configOf _entity >> "maximumLoad") > 0}
    }
] call EFUNC(attributes,addButton);

ADDON = true;
