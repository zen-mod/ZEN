#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Add pylons button to attribute display
[
    "Object",
    LSTRING(DisplayName),
    {
        _entity call FUNC(configure);
    },
    {
        alive _entity && {_entity call EFUNC(common,hasPylons)}
    }
] call EFUNC(attributes,addButton);

ADDON = true;
