#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

// Disable CBA inventory attribute preload
uiNamespace setVariable ["cba_ui_curatorItemCache", []];

[
    "Object",
    "STR_A3_Gear1",
    {
        [_entity, "Inventory"] call EFUNC(attributes,open);
    },
    {
        alive _entity && {getNumber (configFile >> "CfgVehicles" >> typeOf _entity >> "maximumLoad") > 0}
    }
] call EFUNC(attributes,addButton);

[
    "Inventory",
    "",
    QGVAR(attribute),
    nil,
    {
        [_entity, _value] call EFUNC(common,setInventory)
    },
    {_entity call EFUNC(common,getInventory)}
] call EFUNC(attributes,addAttribute);

ADDON = true;
