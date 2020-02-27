#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Add loadout button to attribute display
[
    "Object",
    LSTRING(button),
    {
        [_entity] call FUNC(configure);
    },
    {
        alive _entity && {!(_entity call FUNC(getWeaponList) isEqualTo [])}
    }
] call EFUNC(attributes,addButton);

ADDON = true;
