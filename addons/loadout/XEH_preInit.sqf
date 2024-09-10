#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Add loadout button to attribute display
[
    "Object",
    "STR_A3_VR_Stamina_01_Loadout",
    {
        [_entity] call FUNC(configure);
    },
    {
        alive _entity && {_entity call FUNC(getWeaponList) isNotEqualTo []}
    }
] call EFUNC(attributes,addButton);

ADDON = true;
